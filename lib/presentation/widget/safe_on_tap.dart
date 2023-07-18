import 'package:flutter/widgets.dart';

class SafeOnTap extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onSafeTap;
  final int intervalMs;

  const SafeOnTap({
    Key? key,
    required this.child,
    required this.onSafeTap,
    this.intervalMs = 1000,
  }) : super(key: key);

  @override
  State<SafeOnTap> createState() => _SafeOnTapState();
}

class _SafeOnTapState extends State<SafeOnTap> {
  int lastTimeClicked = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - lastTimeClicked < widget.intervalMs) {
          return;
        }
        lastTimeClicked = now;
        widget.onSafeTap();
      },
      child: widget.child,
    );
  }
}
