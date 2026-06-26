import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';

class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static Future<void> init(BuildContext context) async {
    try {
      // 1. Request notifications permission
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted notification permission');
      } else {
        log('User declined or has not accepted notification permission');
      }

      // 2. Fetch and register the FCM token
      String? token = await _fcm.getToken();
      if (token != null) {
        log('FCM Token: $token');
        if (context.mounted) {
          context.read<AuthBloc>().add(AuthUpdateFcmToken(token));
        }
      }

      // 3. Listen to token refresh
      _fcm.onTokenRefresh.listen((newToken) {
        log('FCM Token Refreshed: $newToken');
        if (context.mounted) {
          context.read<AuthBloc>().add(AuthUpdateFcmToken(newToken));
        }
      });

      // 4. Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Received foreground message: ${message.notification?.title}');
        if (context.mounted && message.notification != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.notification!.title ?? 'Notifikasi',
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message.notification!.body ?? '',
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
              backgroundColor: const Color(0xFF141B2D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      });
    } catch (e) {
      log('Error initializing NotificationService: $e');
    }
  }
}
