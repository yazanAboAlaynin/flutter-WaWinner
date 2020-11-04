import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';

class Api {
  static const baseUrl = 'https://www.';

  Map<String, String> setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Map<String, String>> getHeaders() async => {
        'Content-type': 'application/x-www-form-urlencoded',
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
