// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Training`
  String get title {
    return Intl.message(
      'Training',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Hello World! My name is {myName}`
  String helloWorld(Object myName) {
    return Intl.message(
      'Hello World! My name is $myName',
      name: 'helloWorld',
      desc: '',
      args: [myName],
    );
  }

  /// `I live in {city}, {country}`
  String address(Object city, Object country) {
    return Intl.message(
      'I live in $city, $country',
      name: 'address',
      desc: '',
      args: [city, country],
    );
  }

  /// `Number : {value}`
  String myNumber(Object value) {
    return Intl.message(
      'Number : $value',
      name: 'myNumber',
      desc: '',
      args: [value],
    );
  }

  /// `Today's date : {dateNow}`
  String todayDate(Object dateNow) {
    return Intl.message(
      'Today\'s date : $dateNow',
      name: 'todayDate',
      desc: '',
      args: [dateNow],
    );
  }

  /// `{count,plural, =0{no apples} other{{count} apples}}`
  String myApple(num count) {
    return Intl.plural(
      count,
      zero: 'no apples',
      other: '$count apples',
      name: 'myApple',
      desc: '',
      args: [count],
    );
  }

  /// `You do {count,plural, =0{not have {thing}} other{have {count} {thing}}}`
  String nThings(num count, Object thing) {
    return Intl.message(
      'You do ${Intl.plural(count, zero: 'not have $thing', other: 'have $count $thing')}',
      name: 'nThings',
      desc: '',
      args: [count, thing],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'id'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
