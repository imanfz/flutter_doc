import 'package:flutter/material.dart';
import 'package:flutter_doc/core/widget/safe_on_tap.dart';
import 'package:flutter_doc/core/utils/extensions/sizes_ext.dart';

extension WidgetExt on Widget {
  Widget paddingHorizontal(double padding) =>
      Padding(padding: padding.paddingHorizontal, child: this);

  Widget paddingVertical(double padding) =>
      Padding(padding: padding.paddingVertical, child: this);

  Widget paddingAll(double padding) =>
      Padding(padding: padding.paddingAll, child: this);

  Widget paddingTop(double padding) =>
      Padding(padding: padding.paddingTop, child: this);

  Widget paddingBottom(double padding) =>
      Padding(padding: padding.paddingBottom, child: this);

  Widget paddingLeft(double padding) =>
      Padding(padding: padding.paddingLeft, child: this);

  Widget paddingRight(double padding) =>
      Padding(padding: padding.paddingRight, child: this);

  Widget center() => Center(child: this);

  Widget onSafeTap(VoidCallback onTap) =>
      SafeOnTap(child: this, onSafeTap: onTap);
}
