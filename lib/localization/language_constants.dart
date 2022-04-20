import 'package:demo/constants/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo/localization/localization.dart';
import 'package:flutter/material.dart';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(Variables.langCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String _languageCode =
      _prefs.getString(Variables.langCode) ?? Variables.arabicLangCode;
  return _locale(_languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case Variables.englishLangCode:
      return const Locale(
          Variables.englishLangCode, Variables.englishCountryCode);
    case Variables.arabicLangCode:
      return const Locale(
          Variables.arabicLangCode, Variables.arabicCountryCode);
    default:
      return const Locale(
          Variables.arabicLangCode, Variables.arabicCountryCode);
  }
}

String? getTranslated(BuildContext context, String key) {
  return Localization.of(context)!.translate(key);
}
