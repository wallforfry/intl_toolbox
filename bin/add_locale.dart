#!/usr/bin/env dart
library generate;

import 'package:intl_toolbox/intl_toolbox.dart';

main(List<String> args) {
  IntlToolbox.addLocale(args[0]);
}
