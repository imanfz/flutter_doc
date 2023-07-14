import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc/utilities/extensions/colors_ext.dart';
import 'package:flutter_doc/utilities/extensions/navigator_ext.dart';
import 'package:flutter_doc/utilities/extensions/sizes_ext.dart';
import 'package:flutter_doc/utilities/extensions/widget_ext.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../presentation/widget/safe_button.dart';

extension ContextExt<T> on BuildContext {
  // Lock orientation to portrait only
  void setOrientationPortraitOnly() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  // Screen Size
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  bool get isSmallTablet =>
      MediaQuery.of(this).size.width < 650.0 &&
      MediaQuery.of(this).size.width > 500.0;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall =>
      MediaQuery.of(this).size.width < 850.0 &&
      MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;

  Future<T?> showAlertDialog(String title, String message) {
    return showDialog(
      context: this,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Stack(
            children: <Widget>[Text(message)],
          ),
          actions: <Widget>[
            SafeButton.text(
              label: 'Close',
              onPressed: context.navigator.pop,
            ),
          ],
        );
      },
    );
  }

  Future<T?> showActionDialog(String title, String message,
      {String? actionText,
      required Function()? onPressed,
      bool dismissible = false}) {
    return showDialog(
      context: this,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Stack(
            children: <Widget>[Text(message)],
          ),
          actions: <Widget>[
            SafeButton.text(
              label: actionText ?? "Yes",
              onPressed: () {
                context.navigator.pop();
                onPressed!();
              },
            ),
            SafeButton.text(
              label: "Cancel",
              onPressed: () {
                context.navigator.pop();
                onPressed!();
              },
            ),
          ],
        );
      },
    );
  }

  Future<T?> showCustomDialog(AlertDialog alertDialog,
      {bool dismissible = false}) {
    return showDialog(
      context: this,
      barrierDismissible: dismissible,
      builder: (_) {
        // return object of type Dialog
        return alertDialog;
      },
    );
  }

  // Pop-ups
  Future<T?> showBottomSheet(Widget child,
      {bool isScrollControlled = true,
      Color? backgroundColor,
      Color? barrierColor}) {
    return showModalBottomSheet(
      context: this,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => Container(
        width: double.infinity,
        padding: 16.paddingAll,
        child: child,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    showCloseIcon = false,
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: showCloseIcon,
        action: action,
      ),
    );
  }

  Future<bool?> showToast(String message) {
    // It's a plugin to show toast and we can with extension
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: primary,
      textColor: onPrimary,
    );
  }

  showLoading() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Loading"),
            ],
          ).paddingVertical(16),
        );
      },
    );
  }

  hideLoading() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
