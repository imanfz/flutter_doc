import 'dart:async';
import 'dart:developer' as devtools show log;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// DevTools extensions
extension DevTools on Object {
  // creating TAG from classname
  String get TAG => runtimeType.toString();

  /// Logs an Object
  ///
  /// Instead of doing
  /// `log(object.toString())`
  /// you can do
  /// `object.log()`

  /// For debug mode, otherwise it doesn't show up
  void logD(String message, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      devtools.log(message, name: TAG, stackTrace: stackTrace);
    }
  }

  /// For all mode
  void logI(String message, {StackTrace? stackTrace}) {
    devtools.log(message, name: TAG, stackTrace: stackTrace);
  }
}

/// Allows to insert a separator between the items of the iterable.
extension SeparatedIterable on Iterable<Widget> {
  /// Allows to insert a [separator] between the items of the iterable.
  List<Widget> separatedBy(
    Widget separator, {
    bool? withFirst,
    bool? withLast,
  }) {
    final result = <Widget>[];
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      /// added a top separator as needed
      if (withFirst == true) {
        result.add(separator);
      }
      result.add(iterator.current);
      while (iterator.moveNext()) {
        result
          ..add(separator)
          ..add(iterator.current);
      }

      /// added a bottom separator as needed
      if (withLast == true) {
        result.add(separator);
      }
    }
    return result;
  }

  /// Allows to insert a space between the items of the iterable.
  List<Widget> spaceBetween({
    double? width,
    double? height,
    bool? withFirst,
    bool? withLast,
  }) {
    final result = <Widget>[];
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      /// added a top separator as needed
      if (withFirst == true) {
        result.add(SizedBox(width: width, height: height));
      }
      result.add(iterator.current);
      while (iterator.moveNext()) {
        result
          ..add(SizedBox(width: width, height: height))
          ..add(iterator.current);
      }

      /// added a bottom separator as needed
      if (withLast == true) {
        result.add(SizedBox(width: width, height: height));
      }
    }
    return result;
  }
}

/// Provides conversions from [num] to [Duration]
extension DurationExt on num {
  /// Converts the number into a [Duration] in microseconds
  Duration get microseconds => Duration(microseconds: round());

  /// Converts the number into a [Duration] in milliseconds
  Duration get milliseconds => Duration(milliseconds: round());

  /// Converts the number into a [Duration] in seconds
  Duration get seconds => Duration(seconds: round());

  /// Converts the number into a [Duration] in minutes
  Duration get minutes => Duration(minutes: round());

  /// Converts the number into a [Duration] in hours
  Duration get hours => Duration(hours: round());

  /// Converts the number into a [Duration] in days
  Duration get days => Duration(days: round());

  /// Converts the number into a [Duration] in months
  Duration get months => Duration(days: 30 * round());

  /// Converts the number into a [Duration] in quarters
  Duration get quarters => Duration(days: 90 * round());

  /// Converts the number into a [Duration] in quadrimesters
  Duration get quadrimesters => Duration(days: 120 * round());

  /// Converts the number into a [Duration] in years
  Duration get years => Duration(days: 365 * round());
}

/// Convert a [Duration] into a [Future].
extension FutureDuration on Duration {
  /// Creates a future that runs its computation after a delay.
  ///
  /// The [computation] will be executed after the given [Duration] has passed,
  /// and the future is completed with the result of the computation.
  ///
  /// If [computation] returns a future,
  /// the future returned by this constructor will complete with the value or
  /// error of that future.
  ///
  /// If the duration is 0 or less,
  /// it completes no sooner than in the next event-loop iteration,
  /// after all microtasks have run.
  ///
  /// If [computation] is omitted,
  /// it will be treated as if [computation] was `() => null`,
  /// and the future will eventually complete with the `null` value.
  ///
  /// If calling [computation] throws, the created future will complete with the
  /// error.
  Future<dynamic> future([FutureOr<dynamic> Function()? computation]) {
    return Future.delayed(this, computation);
  }
}