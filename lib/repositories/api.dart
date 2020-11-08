import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';

class Api {
  static const baseUrl = 'https://wawwinner.ae/dev/public/api';

  Map<String, String> setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': 'en'
      };
// x-www-form-urlencoded
  Future<Map<String, String>> getHeaders() async => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': await getToken()
      };

  Future<Map<String, String>> gHeaders() async => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'token': await getToken()
      };

  Future<Map<String, String>> getHeaderToken() async =>
      {'token': await getToken()};

  Future getToken() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();

    // return localStorage.getString('token');
  }
}
