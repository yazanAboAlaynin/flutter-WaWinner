import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'localization.dart';

String LANGUAGE = 'en';

String getTranslated(BuildContext context, String key) {
  return Localization.of(context).getTranslatedValue(key);
}

const String ENGLISH = 'en';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  await _prefs.setString('languageCode', languageCode);
  LANGUAGE = languageCode;
  return _locale(languageCode);
}

Locale _locale(languageCode) {
  Locale temp;
  switch (languageCode) {
    case 'en':
      temp = Locale(languageCode, 'US');
      break;
    case 'ar':
      temp = Locale(languageCode, 'SA');
      break;
    default:
      temp = Locale(languageCode, 'US');
  }
  return temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String lang = _prefs.getString('languageCode') ?? 'en';
  LANGUAGE = lang;
  return _locale(lang);
}

Future getInfo() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
}

Future clearStorage() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (_prefs.containsKey('token')) {
    _prefs.remove('cart');
  }
}
