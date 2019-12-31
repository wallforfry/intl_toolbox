import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../res/string_resources.dart';
import '../l10n/dart/messages_all.dart';
import 'app_localizations_delegate.dart';
import 'fallback_localizations_delegate.dart';

class AppLocalizations with StringResources {
  static List<LocalizationsDelegate> get localizationsDelegate => [
        AppLocalizationsDelegate(),
        FallbackLocalizationDelegate(),
      ];

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}
