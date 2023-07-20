import 'package:flutter/material.dart';

enum _StyleEnum { primary, flat, outlined, text, floating }

class SafeButton extends StatefulWidget {
  /// Icon of the button
  final IconData? icon;

  /// Label of the button
  final String label;

  /// Padding of the inside of the button
  final EdgeInsets? padding;

  /// Action of the button, if null, will go to disabled state
  final Function()? onPressed;

  /// Style of button
  final _StyleEnum _styleEnum;

  /// Background color of the button
  final Color? backgroundColor;

  /// Foreground color of the button
  final Color? foregroundColor;

  /// Borderraius of the button
  final double? borderRadius;

  final double? elevation;

  final int intervalMs;

  const SafeButton._({
    Key? key,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.borderRadius,
    this.elevation,
    required _StyleEnum styleEnum,
    required this.label,
    required this.onPressed,
  })  : _styleEnum = styleEnum,
        intervalMs = 1000,
        super(key: key);

  /// Primary button
  factory SafeButton.primary({
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets? padding,
    double? borderRadius,
    double? elevation,
    required String label,
    required Function()? onPressed,
  }) {
    return SafeButton._(
      icon: icon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      borderRadius: borderRadius,
      elevation: elevation,
      styleEnum: _StyleEnum.primary,
      label: label,
      onPressed: onPressed,
    );
  }

  /// Flat button
  factory SafeButton.flatt({
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets? padding,
    double? borderRadius,
    double? elevation,
    required String label,
    required Function()? onPressed,
  }) {
    return SafeButton._(
      icon: icon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      borderRadius: borderRadius,
      elevation: elevation,
      styleEnum: _StyleEnum.flat,
      label: label,
      onPressed: onPressed,
    );
  }

  /// Outlined button
  factory SafeButton.outlined({
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets? padding,
    double? borderRadius,
    double? elevation,
    required String label,
    required Function()? onPressed,
  }) {
    return SafeButton._(
      icon: icon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      borderRadius: borderRadius,
      elevation: elevation,
      styleEnum: _StyleEnum.outlined,
      label: label,
      onPressed: onPressed,
    );
  }

  /// Text button
  factory SafeButton.text({
    IconData? icon,
    Color? foregroundColor,
    EdgeInsets? padding,
    required String label,
    required Function()? onPressed,
  }) {
    return SafeButton._(
      icon: icon,
      foregroundColor: foregroundColor,
      padding: padding,
      styleEnum: _StyleEnum.text,
      label: label,
      onPressed: onPressed,
    );
  }

  /// Circle button
  factory SafeButton.floating({
    Color? backgroundColor,
    Color? foregroundColor,
    String? tooltip,
    double? elevation,
    required IconData icon,
    required Function()? onPressed,
  }) {
    return SafeButton._(
      icon: icon,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      label: tooltip ?? "",
      elevation: elevation,
      styleEnum: _StyleEnum.floating,
      onPressed: onPressed,
    );
  }

  @override
  State<SafeButton> createState() => _SafeButtonState();
}

class _SafeButtonState extends State<SafeButton> {
  int lastTimeClicked = 0;

  @override
  Widget build(BuildContext context) {
    OutlinedBorder? outlinedBorder;
    if (widget.borderRadius != null) {
      outlinedBorder = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius!),
      );
    }
    switch (widget._styleEnum) {
      case _StyleEnum.primary:
        final style = ElevatedButton.styleFrom(
          elevation: widget.elevation,
          padding: widget.padding,
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.foregroundColor,
          shape: outlinedBorder,
        );
        if (widget.icon != null) {
          return ElevatedButton.icon(
            style: style,
            onPressed: () {
              final now = DateTime.now().millisecondsSinceEpoch;
              if (now - lastTimeClicked < widget.intervalMs) {
                return;
              }
              lastTimeClicked = now;
              widget.onPressed!();
            },
            icon: Icon(widget.icon),
            label: Text(widget.label),
          );
        }
        return ElevatedButton(
          style: style,
          onPressed: () {
            final now = DateTime.now().millisecondsSinceEpoch;
            if (now - lastTimeClicked < widget.intervalMs) {
              return;
            }
            lastTimeClicked = now;
            widget.onPressed!();
          },
          child: Text(widget.label),
        );

      case _StyleEnum.flat:
        if (widget.icon != null) {
          return MaterialButton(
            minWidth: double.infinity,
            color: widget.backgroundColor,
            textColor: widget.foregroundColor,
            shape: outlinedBorder,
            onPressed: () {
              final now = DateTime.now().millisecondsSinceEpoch;
              if (now - lastTimeClicked < widget.intervalMs) {
                return;
              }
              lastTimeClicked = now;
              widget.onPressed!();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon),
                const SizedBox(width: 12.0),
                Text(widget.label),
              ],
            ),
          );
        }
        return MaterialButton(
          minWidth: double.infinity,
          color: widget.backgroundColor,
          textColor: widget.foregroundColor,
          shape: outlinedBorder,
          onPressed: () {
            final now = DateTime.now().millisecondsSinceEpoch;
            if (now - lastTimeClicked < widget.intervalMs) {
              return;
            }
            lastTimeClicked = now;
            widget.onPressed!();
          },
          child: Text(widget.label),
        );

      case _StyleEnum.outlined:
        final style = OutlinedButton.styleFrom(
          elevation: widget.elevation,
          padding: widget.padding,
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.foregroundColor,
          shape: outlinedBorder,
        );
        if (widget.icon != null) {
          return OutlinedButton.icon(
            style: style,
            onPressed: () {
              final now = DateTime.now().millisecondsSinceEpoch;
              if (now - lastTimeClicked < widget.intervalMs) {
                return;
              }
              lastTimeClicked = now;
              widget.onPressed!();
            },
            icon: Icon(widget.icon),
            label: Text(widget.label),
          );
        }
        return OutlinedButton(
          style: style,
          onPressed: () {
            final now = DateTime.now().millisecondsSinceEpoch;
            if (now - lastTimeClicked < widget.intervalMs) {
              return;
            }
            lastTimeClicked = now;
            widget.onPressed!();
          },
          child: Text(widget.label),
        );

      case _StyleEnum.text:
        final style = TextButton.styleFrom(
          padding: widget.padding,
          foregroundColor: widget.foregroundColor,
        );
        if (widget.icon != null) {
          return TextButton.icon(
            style: style,
            onPressed: () {
              final now = DateTime.now().millisecondsSinceEpoch;
              if (now - lastTimeClicked < widget.intervalMs) {
                return;
              }
              lastTimeClicked = now;
              widget.onPressed!();
            },
            icon: Icon(widget.icon),
            label: Text(widget.label),
          );
        }
        return TextButton(
          style: style,
          onPressed: () {
            final now = DateTime.now().millisecondsSinceEpoch;
            if (now - lastTimeClicked < widget.intervalMs) {
              return;
            }
            lastTimeClicked = now;
            widget.onPressed!();
          },
          child: Text(widget.label),
        );

      case _StyleEnum.floating:
        return FloatingActionButton(
          elevation: widget.elevation,
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.foregroundColor,
          tooltip: widget.label.isEmpty ? null : widget.label,
          onPressed: () {
            final now = DateTime.now().millisecondsSinceEpoch;
            if (now - lastTimeClicked < widget.intervalMs) {
              return;
            }
            lastTimeClicked = now;
            widget.onPressed!();
          },
          shape: const CircleBorder(),
          child: Icon(widget.icon),
        );
    }
  }
}
