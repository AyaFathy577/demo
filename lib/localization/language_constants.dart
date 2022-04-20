import 'package:demo/constants/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo/localization/localization.dart';
import 'package:flutter/material.dart';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(langCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String _languageCode = _prefs.getString(langCode) ?? arabicLangCode;
  return _locale(_languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case englishLangCode:
      return const Locale(englishLangCode, englishCountryCode);
    case arabicLangCode:
      return const Locale(arabicLangCode, arabicCountryCode);
    default:
      return const Locale(arabicLangCode, arabicCountryCode);
  }
}

String? getTranslated(BuildContext context, String key) {
  return Localization.of(context)!.translate(key);
}
