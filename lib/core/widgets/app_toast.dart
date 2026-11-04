import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

abstract final class AppToast {
  static OverlayEntry? _current;

  static void show(
    BuildContext context,
    String message, {
    IconData icon = Icons.check_circle_rounded,
  }) {
    _current?.remove();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _ToastView(
        message: message,
        icon: icon,
        onFinished: () {
          if (_current == entry) {
            entry.remove();
            _current = null;
          }
        },
      ),
    );

    _current = entry;
    Overlay.of(context).insert(entry);

    // TODO(a11y): [M1 Status message]
    // The toast is only visual, so screen reader users hear nothing after "Add
    // to basket" or "Place order".
    // Fix: announce the message. This one line fixes every toast in the app.
    // Also add `import 'package:flutter/semantics.dart';` at the top.
    //
    //   SemanticsService.sendAnnouncement(
    //     View.of(context),
    //     message,
    //     Directionality.of(context),
    //   );
  }
}

class _ToastView extends StatefulWidget {
  const _ToastView({
    required this.message,
    required this.icon,
    required this.onFinished,
  });

  final String message;
  final IconData icon;
  final VoidCallback onFinished;

  @override
  State<_ToastView> createState() => _ToastViewState();
}

class _ToastViewState extends State<_ToastView>
    with SingleTickerProviderStateMixin {
  static const _visibleFor = Duration(seconds: 2);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(_visibleFor, _hide);
  }

  Future<void> _hide() async {
    await _controller.reverse();
    if (mounted) widget.onFinished();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return Positioned(
      left: 24,
      right: 24,
      bottom: 32 + bottomInset,
      child: IgnorePointer(
        child: FadeTransition(
          opacity: _controller,
          child: Material(
            color: AppColors.toastBackground,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(widget.icon, color: Colors.lightGreenAccent, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
