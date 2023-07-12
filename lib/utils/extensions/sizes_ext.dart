import 'package:flutter/material.dart';

/// Helper extension that allows to use a size like:
/// `context.sizes.width`
extension Sizes on BuildContext {
  /// The list of sizes available to the app
  SizesData get sizes => SizesData(
        width: _width,
        height: _height,
        padding: _padding,
        viewInsets: _viewInsets,
        systemGestureInsets: _systemGestureInsets,
        viewPadding: _viewPadding,
        devicePixelRatio: _devicePixelRatio,
        textScaleFactor: _textScaleFactor,
        maybeDevicePixelRatio: _maybeDevicePixelRatio,
        maybeHeight: _maybeHeight,
        maybePadding: _maybePadding,
        maybeSystemGestureInsets: _maybeSystemGestureInsets,
        maybeTextScaleFactor: _maybeTextScaleFactor,
        maybeViewInsets: _maybeViewInsets,
        maybeViewPadding: _maybeViewPadding,
        maybeWidth: _maybeWidth,
      );

  double get _width => MediaQuery.sizeOf(this).width;
  double? get _maybeWidth => MediaQuery.maybeSizeOf(this)?.width;
  double get _height => MediaQuery.sizeOf(this).height;
  double? get _maybeHeight => MediaQuery.maybeSizeOf(this)?.height;
  EdgeInsets get _padding => MediaQuery.paddingOf(this);
  EdgeInsets? get _maybePadding => MediaQuery.maybePaddingOf(this);
  EdgeInsets get _viewInsets => MediaQuery.viewInsetsOf(this);
  EdgeInsets? get _maybeViewInsets => MediaQuery.maybeViewInsetsOf(this);
  EdgeInsets get _systemGestureInsets => MediaQuery.systemGestureInsetsOf(this);
  EdgeInsets? get _maybeSystemGestureInsets =>
      MediaQuery.maybeSystemGestureInsetsOf(this);
  EdgeInsets get _viewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets? get _maybeViewPadding => MediaQuery.maybeViewPaddingOf(this);
  double get _devicePixelRatio => MediaQuery.devicePixelRatioOf(this);
  double? get _maybeDevicePixelRatio =>
      MediaQuery.maybeDevicePixelRatioOf(this);
  double get _textScaleFactor => MediaQuery.textScaleFactorOf(this);
  double? get _maybeTextScaleFactor => MediaQuery.maybeTextScaleFactorOf(this);
}

class SizesData {
  const SizesData({
    required this.width,
    required this.height,
    required this.padding,
    required this.viewInsets,
    required this.systemGestureInsets,
    required this.viewPadding,
    required this.devicePixelRatio,
    required this.textScaleFactor,
    required this.maybeWidth,
    required this.maybeHeight,
    required this.maybePadding,
    required this.maybeViewInsets,
    required this.maybeSystemGestureInsets,
    required this.maybeViewPadding,
    required this.maybeDevicePixelRatio,
    required this.maybeTextScaleFactor,
  });

  /// See [Size.width].
  final double width;

  /// See [Size.width].
  final double? maybeWidth;

  /// See [Size.height].
  final double height;

  /// See [Size.height].
  final double? maybeHeight;

  /// See [MediaQueryData.padding].
  final EdgeInsets padding;

  /// See [MediaQueryData.padding].
  final EdgeInsets? maybePadding;

  /// See [MediaQueryData.viewInsets].
  final EdgeInsets viewInsets;

  /// See [MediaQueryData.viewInsets].
  final EdgeInsets? maybeViewInsets;

  /// See [MediaQueryData.systemGestureInsets].
  final EdgeInsets systemGestureInsets;

  /// See [MediaQueryData.systemGestureInsets].
  final EdgeInsets? maybeSystemGestureInsets;

  /// See [MediaQueryData.viewPadding].
  final EdgeInsets viewPadding;

  /// See [MediaQueryData.viewPadding].
  final EdgeInsets? maybeViewPadding;

  /// See [MediaQueryData.devicePixelRatio].
  final double devicePixelRatio;

  /// See [MediaQueryData.devicePixelRatio].
  final double? maybeDevicePixelRatio;

  /// See [MediaQueryData.textScaleFactor].
  final double textScaleFactor;

  /// See [MediaQueryData.textScaleFactor].
  final double? maybeTextScaleFactor;
}

/// Converts a [num] into an [EdgeInsets]
extension PaddingNum on num {
  /// Creates insets where all the offsets are `value`.
  EdgeInsets get paddingAll => EdgeInsets.all(toDouble());

  /// Creates insets with symmetric horizontal offsets.
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Creates insets with symmetric vertical offsets.
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: toDouble());

  /// Creates insets with only the top value.
  EdgeInsets get paddingTop => EdgeInsets.only(top: toDouble());

  /// Creates insets with only the left value.
  EdgeInsets get paddingLeft => EdgeInsets.only(left: toDouble());

  /// Creates insets with only the right value.
  EdgeInsets get paddingRight => EdgeInsets.only(right: toDouble());

  /// Creates insets with only the bottom value.
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: toDouble());
}
