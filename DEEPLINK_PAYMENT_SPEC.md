# Spesifikasi Deeplink Pembayaran — Dompet Kampus Global

Dokumen ini menjelaskan format URL, konfigurasi platform, dan alur end-to-end agar aplikasi Dompet Kampus Global dapat menerima link pembayaran dari merchant/aplikasi lain (deeplink), menampilkan halaman konfirmasi, dan menyelesaikan pembayaran dengan verifikasi PIN + 2FA (OTP Email / TOTP / Notifikasi Firebase) sesuai konfigurasi keamanan masing-masing user.

Dokumen spesifikasi teknis untuk developer, QA, dan merchant integrator. Isi:
- Format URL deeplink — custom scheme + HTTPS App Link
- Tabel parameter lengkap (wajib/opsional, tipe, keterangan, validasi)
- Konfigurasi platform Android (`AndroidManifest.xml`) dan iOS (`Info.plist`)
- Diagram alur end-to-end: dari klik link hingga halaman sukses
- Tabel mapping `k2faMethod` → `otp_type` → UI yang ditampilkan
- Contoh link siap pakai
- Perintah testing: adb (Android) dan xcrun simctl (iOS Simulator)
- Tabel 10 skenario uji
- Catatan keamanan: validasi backend, wajib 2FA, larangan auto-redirect callback

---

## 1. Format URL Deeplink

Dua skema didukung:

| Tipe | Contoh |
| :--- | :--- |
| **Custom scheme** (selalu aktif) | `dompetkampus://pay?merchant_id=MCH001&merchant_name=Kantin%20Kampus&amount=25000&description=Makan%20siang&reference=INV-2026-0001&callback=https://merchant.example.com/return` |
| **HTTPS App Link** (opsional, butuh `assetlinks.json`) | `https://dompetkampus.app/pay?merchant_id=MCH001&merchant_name=Kantin%20Kampus&amount=25000` |

### Parameter URL

| Parameter | Wajib | Tipe | Keterangan |
| :--- | :---: | :--- | :--- |
| `merchant_id` | Yes | string | ID unik merchant. Ditampilkan di ringkasan, tidak boleh kosong. |
| `merchant_name` | Yes | string | Nama merchant yang ditampilkan ke user (URL-encoded). |
| `amount` | Yes | number | Nominal pembayaran dalam Rupiah, tanpa desimal/pemisah (mis. 25000, bukan 25.000). Harus > 0. |
| `description` | No | string | Keterangan transaksi. Default: "Pembayaran ke `<merchant_name>`". |
| `reference` | No | string | Nomor referensi/invoice merchant, ditampilkan di ringkasan dan diteruskan ke layar sukses. |
| `callback` | No | string (URL) | URL callback tujuan (custom scheme atau HTTPS) untuk melaporkan status pembayaran. |

> [!NOTE]
> Semua nilai parameter harus melalui percent-encoding standar URL (spasi → `%20`, `/` pada callback di-encode, dll).

### Validasi Parsing
Parsing dilakukan oleh `DeeplinkPaymentData.fromUri()` di `lib/core/services/deeplink_service.dart`. Jika salah satu kondisi berikut terjadi, aplikasi membuka halaman `/pay` dalam mode error dengan pesan bahasa Indonesia:
1. `merchant_id` tidak ada / kosong
2. `merchant_name` tidak ada / kosong
3. `amount` tidak ada, bukan angka, atau <= 0

---

## 2. Konfigurasi Platform

### Android — `android/app/src/main/AndroidManifest.xml`
Dua `intent-filter` ditambahkan pada `<activity android:name=".MainActivity">`:

```xml
<!-- Custom scheme: dompetkampus://pay?... -->
<intent-filter android:autoVerify="false">
    <action android:name="android.intent.action.VIEW"/>
    <category android:name="android.intent.category.DEFAULT"/>
    <category android:name="android.intent.category.BROWSABLE"/>
    <data android:scheme="dompetkampus" android:host="pay"/>
</intent-filter>

<!-- Opsional App Link (HTTPS): https://dompetkampus.app/pay?... -->
<intent-filter android:autoVerify="false">
    <action android:name="android.intent.action.VIEW"/>
    <category android:name="android.intent.category.DEFAULT"/>
    <category android:name="android.intent.category.BROWSABLE"/>
    <data android:scheme="https" android:host="dompetkampus.app" android:pathPrefix="/pay"/>
</intent-filter>
```

### iOS — `ios/Runner/Info.plist`
Registrasi URL Scheme `dompetkampus://`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.kampus.dompetKampusGlobal.payment</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>dompetkampus</string>
        </array>
    </dict>
</array>
```

---

## 3. Komponen di Sisi Flutter

| File | Peran |
| :--- | :--- |
| `lib/core/services/deeplink_service.dart` | `DeeplinkPaymentData` (model + parser/validator) dan `DeeplinkService` (listener app_links → navigasi GoRouter). |
| `lib/core/services/deeplink_callback_service.dart` | Mengirim callback kembali ke aplikasi merchant (best-effort). |
| `lib/core/router/app_router.dart` | singleton router, route `/pay` → `PaymentDeeplinkPage`. |
| `lib/presentation/pages/payment/payment_deeplink_page.dart` | Halaman ringkasan pembayaran (merchant, nominal, deskripsi, referensi) + tombol "Bayar". |
| `lib/presentation/pages/payment/pin_page.dart` | Input PIN → lanjut ke step OTP/TOTP sesuai `k2faMethod` → submit ke `PaymentBloc`. |
| `lib/main.dart` | `DeeplinkService(AppRouter.router).init()` dipanggil sekali saat startup. |

---

## 4. Alur End-to-End

1. User membuka link dari aplikasi merchant / browser:
   `dompetkampus://pay?merchant_id=...&merchant_name=...&amount=...`
2. OS meneruskan URI ke aplikasi (cold start via `getInitialLink()` atau in-app via `uriLinkStream`).
3. `DeeplinkService._handleUri()`:
   - Jika valid → navigasi ke `/pay` dengan extra data `DeeplinkPaymentData`.
   - Jika tidak valid → navigasi ke `/pay` dengan extra data `String` (pesan error).
4. `PaymentDeeplinkPage` menampilkan detail pembayaran:
   - Tombol "Bayar Rp xxx" mengarahkan ke `/pin` dengan flow data.
   - Tombol back/cancel mengirim callback `cancelled` ke merchant (jika ada `callbackUrl`).
5. `PinPage` — Step 1 (PIN):
   - User memasukkan 6 digit PIN.
   - Jika `kind == 'topup'` → langsung panggil `PaymentTopupRequested` (tanpa OTP).
   - Kind lainnya → lanjut ke Step 2 (OTP).
6. `PinPage` — Step 2 (2FA / OTP):
   - Mengambil metode 2FA dari `SecureStorage` (key: `k2faMethod`).
   - `totp` (default) → tampilkan `CodeInput` untuk kode Google Authenticator.
   - `smtp` → kirim OTP via SMTP (`OtpSendEmail`), tampilkan input + countdown 60s.
   - `notif` → kirim OTP via Firebase Cloud Messaging (`OtpSendFirebase`), tampilkan input + countdown 60s.
7. Setelah 6 digit kode OTP terisi, submit `PaymentTransferRequested` ke `/v1/payment/transfer`.
8. Response backend:
   - `200 OK` → kirim callback `success` ke merchant, navigasi ke `/success`.
   - `401 INVALID_OTP` → reset input OTP, tampilkan banner error.
   - `400 INSUFFICIENT_BALANCE` → kirim callback `failed`, tampilkan SnackBar saldo kurang.
   - Lainnya → kirim callback `failed`, tampilkan SnackBar error.

---

## 5. Contoh Link Lengkap
- **Custom Scheme:**
  `dompetkampus://pay?merchant_id=MCH001&merchant_name=Kantin%20Kampus%20A&amount=25000&description=Makan%20Siang%20Paket%202&reference=INV-20260616-0001`
- **App Link HTTPS:**
  `https://dompetkampus.app/pay?merchant_id=MCH002&merchant_name=Koperasi%20Mahasiswa&amount=15000`

---

## 6. Testing

### Android (adb shell)
*Untuk CMD (Windows):*
```cmd
adb shell am start -a android.intent.action.VIEW -d "dompetkampus://pay?merchant_id=MCH001^&merchant_name=Kantin%20Kampus^&amount=25000^&description=Makan%20Siang^&reference=INV-001"
```

*Untuk PowerShell / Linux / macOS Shell:*
```bash
adb shell "am start -a android.intent.action.VIEW -d 'dompetkampus://pay?merchant_id=MCH001&merchant_name=Kantin%20Kampus&amount=25000&description=Makan%20Siang&reference=INV-001'"
```

### iOS Simulator
```bash
xcrun simctl openurl booted "dompetkampus://pay?merchant_id=MCH001&merchant_name=Kantin%20Kampus&amount=25000&description=Makan%20Siang&reference=INV-001"
```

---

## 7. Catatan Keamanan
1. **Validasi Parameter:** API backend harus memverifikasi ulang `merchant_id` dan mencocokkan nominal transaksi demi mencegah modifikasi nominal oleh pengguna di sisi client.
2. **2FA Wajib:** Transaksi debet/transfer selain top-up wajib melewati verifikasi 2FA sesuai dengan tingkat keamanan akun pengguna.
3. **No Auto-Redirect:** Aplikasi tidak boleh secara otomatis mengalihkan pengguna kembali ke merchant callback tanpa interaksi sadar pengguna (misalnya, menekan tombol "Kembali ke Merchant" atau melihat layar sukses terlebih dahulu).
