import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppField extends StatelessWidget {
  final String? label;
  final String placeholder;
  final String value;
  final ValueChanged<String> onChanged;
  final bool obscure;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? error;

  const AppField({
    super.key,
    this.label,
    this.placeholder = '',
    required this.value,
    required this.onChanged,
    this.obscure = false,
    this.inputType,
    this.prefixIcon,
    this.suffix,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = error != null && error!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: AppColors.slate600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hasError ? AppColors.red : AppColors.line,
              width: 2.5,
            ),
            boxShadow: const [
              BoxShadow(color: Color(0x10000000), offset: Offset(3, 3)),
            ],
          ),
          child: TextField(
            controller: TextEditingController.fromValue(
              TextEditingValue(text: value, selection: TextSelection.collapsed(offset: value.length)),
            ),
            onChanged: onChanged,
            obscureText: obscure,
            keyboardType: inputType,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                color: AppColors.slate400,
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 14, right: 10),
                      child: IconTheme(
                        data: const IconThemeData(color: AppColors.slate500, size: 20),
                        child: prefixIcon!,
                      ),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIcon: suffix,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(
            error!,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.red,
            ),
          ),
        ],
      ],
    );
  }
}
