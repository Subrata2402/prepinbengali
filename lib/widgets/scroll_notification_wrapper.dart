import 'package:flutter/material.dart';

class ScrollNotificationWrapper extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool>? onScrollChanged;

  const ScrollNotificationWrapper({
    super.key,
    required this.child,
    this.onScrollChanged,
  });

  @override
  State<ScrollNotificationWrapper> createState() => _ScrollNotificationWrapperState();
}

class _ScrollNotificationWrapperState extends State<ScrollNotificationWrapper> {
  bool _isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final isScrolled = notification.metrics.pixels > 0;
          if (isScrolled != _isScrolled) {
            setState(() {
              _isScrolled = isScrolled;
            });
            widget.onScrollChanged?.call(isScrolled);
          }
        }
        return false;
      },
      child: widget.child,
    );
  }
}
