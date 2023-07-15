# corriol_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

## Translations

To generate translations for an application, the intl and flutter_localizations packages are utilized. These translations are then stored in the lib/l10n/app_XX.arb file. To create the translations, it is necessary to execute the following command: `flutter gen-l10n`. The resulting code will be placed in the .dart_tool/flutter_gen/gen_l10n directory, and can be accessed in the code using the `import 'package:flutter_gen/gen_l10n/app_localizations.dart';` statement.

## [Generate an APK](https://docs.flutter.dev/deployment/android)

1. % flutter build apk --build-name=0.0.1 --build-number=1

## Notes

### Packages

#### [shared_preferences](https://pub.dev/packages/shared_preferences)

- Data may be persisted to disk asynchronously, and there is no guarantee that writes will be persisted to disk after returning, so this plugin must not be used for storing critical data.
