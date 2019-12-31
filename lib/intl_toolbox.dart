library intl_toolbox;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

class IntlToolbox {
  static const String targetBasePath = "lib/";
  static String targetGeneratedPath = p.join(targetBasePath, "generated/");

  static String intlTargetDirName = p.join(targetGeneratedPath, "l10n/");
  static String localizationsTargetDirName =
      p.join(targetGeneratedPath, "localizations/");

  static List<String> directoriesTree = [
    localizationsTargetDirName,
    p.join(intlTargetDirName, "dart/"),
    p.join(intlTargetDirName, "arb/"),
    p.join(targetBasePath, "res/"),
  ];

  static List<Map<String, dynamic>> filesTree = [
    {
      "path": p.join(targetBasePath, "res/string_resources.dart"),
      "override": false,
    },
    {
      "path": p.join(localizationsTargetDirName, "app_localizations.dart"),
      "override": false,
    },
    {
      "path":
          p.join(localizationsTargetDirName, "app_localizations_delegate.dart"),
      "override": true,
    },
    {
      "path": p.join(localizationsTargetDirName, "localizations_util.dart"),
      "override": false,
    },
    {
      "path": p.join(
          localizationsTargetDirName, "fallback_localizations_delegate.dart"),
      "override": false,
    },
  ];

  static void copyFromTemplates() {
    print("Generate directories tree");
    String modulePath = p.dirname(Platform.script.path);

    for (String path in directoriesTree) {
      Directory(path).createSync(recursive: true);
    }

    print("Create files");
    for (Map<String, dynamic> file in filesTree) {
      String targetPath = p.join(Directory.current.path, file["path"]);

      if (File(targetPath).existsSync() && !file["override"]) continue;

      String templatePath = p.join(modulePath, "../templates", file["path"]);

      File(templatePath).copySync(file["path"]);
    }
  }

  static void generate() {
    copyFromTemplates();

    print("Generate arb files");
    ProcessResult generateArbResult = Process.runSync("flutter", [
      'pub',
      'pub',
      'run',
      'intl_translation:extract_to_arb',
      '--output-dir=${p.join(Directory.current.path, intlTargetDirName, 'arb/')}',
      '${p.join(Directory.current.path, targetBasePath, 'res/', 'string_resources.dart')}'
    ]);

    List<String> arbFiles =
        Directory(p.join(Directory.current.path, intlTargetDirName, 'arb/'))
            .listSync()
            .map((file) => file.path)
            .toList();

    print("Generate dart files");
    List<String> generateDartArgs = [
      'pub',
      'pub',
      'run',
      'intl_translation:generate_from_arb',
      '--output-dir=${p.join(Directory.current.path, intlTargetDirName, 'dart/')}',
      '--no-use-deferred-loading',
      '${p.join(Directory.current.path, targetBasePath, 'res/', 'string_resources.dart')}',
    ];

    generateDartArgs.addAll(arbFiles);

    ProcessResult generateDartResult =
        Process.runSync('flutter', generateDartArgs);

    print("Merging translations");
    Map<String, dynamic> intlMessages = jsonDecode(File(p.join(
            Directory.current.path, intlTargetDirName, 'arb/intl_messages.arb'))
        .readAsStringSync());

    for (String arbPath in arbFiles) {
      if (arbPath.contains('intl_messages.arb')) continue;

      Map<String, dynamic> currentIntl =
          jsonDecode(File(arbPath).readAsStringSync());

      for (String keyToWrite in intlMessages.keys) {
        if (!currentIntl.containsKey(keyToWrite))
          currentIntl[keyToWrite] = intlMessages[keyToWrite];
        else if (keyToWrite == '@@last_modified')
          currentIntl[keyToWrite] = intlMessages[keyToWrite];
        else if (currentIntl.containsKey(keyToWrite.substring(1)) &&
            keyToWrite.startsWith('@'))
          currentIntl[keyToWrite] = intlMessages[keyToWrite];
      }

      for (String keyToDelete in currentIntl.keys.toList()) {
        if (!intlMessages.containsKey(keyToDelete))
          currentIntl.remove(keyToDelete);
      }

      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      File(arbPath).writeAsStringSync(encoder.convert(currentIntl));
    }
    print("Translations generated");
  }

  static void addLocale(String locale) {
    String targetPath = p.join(
        Directory.current.path, intlTargetDirName, 'arb/', 'intl_$locale.arb');

    if (File(targetPath).existsSync()) {
      print("This locale already exist, to overwrite use --force");
      return;
    }

    String templatePath = p.join(
        Directory.current.path, intlTargetDirName, 'arb/', 'intl_messages.arb');

    File(templatePath).copySync(targetPath);
    print("Locale $locale created");
  }
}
