import 'package:demo/localization/language_constants.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  LanguageProvider() {
    getLocale().then((locale) {
      _locale = locale;
    });
  }

  updateLanguage(Locale value) async {
    await setLocale(value.languageCode);
    _locale = value;
    notifyListeners();
  }
}
