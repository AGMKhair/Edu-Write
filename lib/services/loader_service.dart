import 'package:flutter/material.dart';

class LoaderService {
  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  static OverlayEntry? _overlayEntry;

  static GlobalKey<NavigatorState> get navigatorKey => _navKey;

  static void show([BuildContext? context]) {
    if (_overlayEntry != null) return; // Already showing

    _overlayEntry = OverlayEntry(
      builder: (_) => Container(
        color: Colors.black54,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );

    final overlay = _navKey.currentState?.overlay;
    if (overlay != null) {
      overlay.insert(_overlayEntry!);
    }
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
