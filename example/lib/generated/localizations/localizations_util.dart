import 'package:flutter/material.dart';

import 'app_localizations.dart';

class S {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}
