import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:int_toolbox_example/generated/localizations/app_localizations.dart';
import 'package:intl/intl.dart';

mixin StringResources {
  static List<Locale> get supportedLocales =>
      [Locale("en", "EN"), Locale("fr", "FR")];

  static List<LocalizationsDelegate> get localizationsDelegate =>
      AppLocalizations.localizationsDelegate;

  String get title {
    return Intl.message('Intl Toolbox Demo',
        name: 'title', desc: 'The application title');
  }

  String get text {
    return Intl.message('You have pushed the button this many times:',
        name: 'text');
  }

  String get tooltip {
    return Intl.message('Increment', name: 'tooltip');
  }
}
