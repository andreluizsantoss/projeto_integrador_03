import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final LinearGradient? gradient;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.width,
    this.height = 50,
    this.backgroundColor,
    this.textColor,
    this.gradient,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !loading;

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: isEnabled
            ? (gradient ??
                (backgroundColor == null
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF424242), // Grey 800
                          Colors.black,
                        ],
                      )
                    : null))
            : null,
        color: isEnabled
            ? (gradient == null ? backgroundColor : null)
            : AppColors.black.withValues(alpha: 0.6),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    label,
                    style: AppTextStyles.button.copyWith(
                      color: textColor ?? AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
