import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black54,
          child: Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.white,
              size: 50,
            ),
          ),
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  static Future<void> hide(BuildContext context) async {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
