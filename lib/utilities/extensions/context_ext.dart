import 'package:flutter/material.dart';
import 'package:flutter_doc/utilities/extensions/colors_ext.dart';
import 'package:flutter_doc/utilities/extensions/widget_ext.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ContextExt<T> on BuildContext {
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
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<T?> showActionDialog(
      {required String title,
      required String message,
      String? actionText,
      required Function() onPressed,
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
            TextButton(
              onPressed: onPressed,
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<T?> showCustomDialog(
      {required AlertDialog alertDialog, bool dismissible = false}) {
    return showDialog(
      context: this,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        // return object of type Dialog
        return alertDialog;
      },
    );
  }

  // Pop-ups
  Future<T?> showBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
      context: this,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => Wrap(children: [child]),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {required String message, showCloseIcon = false}) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: showCloseIcon,
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
      builder: (BuildContext context) {
        return Dialog(
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 8.0),
              Text("Loading"),
            ],
          ).paddingAll(20),
        );
      },
    );
  }

  hideLoading() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
