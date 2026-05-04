import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';

class AppMessages {
  AppMessages._();

  static void showSuccess(BuildContext context, String message) {
    final overlay = Overlay.of(context, rootOverlay: true);
    showTopSnackBar(
      overlay,
      CustomSnackBar.success(
        message: message,
        backgroundColor: const Color(0xFF0FF32B),
        textStyle: _getTextStyle(context),
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    final overlay = Overlay.of(context, rootOverlay: true);
    showTopSnackBar(
      overlay,
      CustomSnackBar.error(
        message: message,
        backgroundColor: const Color(0xFFFF3A30),
        textStyle: _getTextStyle(context),
      ),
    );
  }

  static void showWarning(BuildContext context, String message) {
    final overlay = Overlay.of(context, rootOverlay: true);
    showWarningInOverlay(overlay, message);
  }

  static void showWarningInOverlay(OverlayState overlay, String message) {
    showTopSnackBar(
      overlay,
      CustomSnackBar.info(
        message: message,
        backgroundColor: const Color(0xFFFFB600),
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    final overlay = Overlay.of(context, rootOverlay: true);
    showTopSnackBar(
      overlay,
      CustomSnackBar.info(
        message: message,
        backgroundColor: const Color(0xFF47AFFF),
        textStyle: _getTextStyle(context),
      ),
    );
  }

  static TextStyle _getTextStyle(BuildContext context) {
    final fontSize = context.isMobile ? 14.0 : 16.0;
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }
}
