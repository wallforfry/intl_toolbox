import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/localizations/app_localizations.dart';

mixin StringResources {
  static List<Locale> get supportedLocales => [
        Locale("en", "EN"),
      ];

  static List<LocalizationsDelegate> get localizationsDelegate =>
      AppLocalizations.localizationsDelegate;

  String get title {
    return Intl.message('Hello world App',
        name: 'title', desc: 'The application title');
  }

  String get hello {
    return Intl.message('Hello', name: 'hello');
  }
}
