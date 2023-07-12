// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'id';

  static String m0(city, country) => "Saya tinggal di ${city}, ${country}";

  static String m1(myName) => "Halo Dunia! Nama saya ${myName}";

  static String m2(count) =>
      "${Intl.plural(count, zero: 'tidak ada apel', other: '${count} apel')}";

  static String m3(value) => "Angka : ${value}";

  static String m4(count, thing) =>
      "Anda ${Intl.plural(count, zero: 'tidak mempunyai ${thing}', other: 'mempunyai ${count} ${thing}')}";

  static String m5(dateNow) => "Tanggal hari ini : ${dateNow}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "address": m0,
        "helloWorld": m1,
        "myApple": m2,
        "myNumber": m3,
        "nThings": m4,
        "title": MessageLookupByLibrary.simpleMessage("Latihan"),
        "todayDate": m5
      };
}
