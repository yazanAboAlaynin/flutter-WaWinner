import 'dart:convert';
import 'dart:io';
import 'package:flutter_wawinner/localization/localization_constants.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';

class Api {
  static const baseUrl = 'https://wawwinner.ae/dev/public/api';

  Map<String, String> setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': '$LANGUAGE',
        'currency': '$CURRENCY'
      };
// x-www-form-urlencoded
  Future<Map<String, String>> getHeaders() async {
    String token = await getToken();
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Accept-Language': '$LANGUAGE',
      'currency': '$CURRENCY'
    };
  }

  Future<Map<String, String>> gHeaders() async => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': TOKEN,
        'Accept-Language': '$LANGUAGE',
        'currency': '$CURRENCY'
      };

  Future<Map<String, String>> getHeaderToken() async =>
      {'token': await getToken()};

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    return localStorage.getString('token');
  }
}
