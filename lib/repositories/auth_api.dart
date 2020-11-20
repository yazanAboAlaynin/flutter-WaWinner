import 'dart:convert';

import 'package:flutter_wawinner/Constants.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import 'package:meta/meta.dart';

class AuthApi extends Api {
  final http.Client httpClient;

  AuthApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<String> login(email, password) async {
    final url = '${Api.baseUrl}/v1/front-end/login';
    var data = {'email': email, 'password': password};
    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: setHeaders());

    var res = jsonDecode(response.body);
    if (res['status']) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = User.fromJson(res['data']['user']);
      preferences.setBool('IsLoggedIn', true);
      preferences.setInt('id', user.id);
      preferences.setString('token', res['data']['token']);
      preferences.setString('email', user.email);
      preferences.setString('first_name', user.first_name);
      preferences.setString('last_name', user.last_name);
      preferences.setString('image', user.image);
      preferences.setString('address', user.address);
      preferences.setString('created_at', user.created_at);
      preferences.setString('updated_at', user.updated_at);
      IsLoggedIn = true;
      EMAIL = user.email;
      FIRST_NAME = user.first_name;
      LAST_NAME = user.last_name;
      ADDRESS = user.address;
      IMAGE = user.image;
      TOKEN = res['data']['token'];
      ID = user.id;
      return "Success";
    } else if (res['message'] == "the account has not been verified") {
      User user = User.fromJson(res['data']);
      ID = user.id;
      return res['message'];
    } else {
      return "Error";
    }
  }

  Future register(data) async {
    final url = '${Api.baseUrl}/v1/front-end/register';

    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: setHeaders());

    var res = jsonDecode(response.body);
    if (res['status']) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = User.fromJson(res['data']);
      preferences.setInt('id', user.id);
      preferences.setString('first_name', user.first_name);
      preferences.setString('last_name', user.last_name);
      preferences.setString('image', user.image);
      preferences.setString('address', user.address);
      preferences.setString('created_at', user.created_at);
      preferences.setString('updated_at', user.updated_at);

      EMAIL = user.email;
      FIRST_NAME = user.first_name;
      LAST_NAME = user.last_name;
      ADDRESS = user.address;
      IMAGE = user.image;
      ID = user.id;
    }
  }

  Future sendCode(data) async {
    final url = '${Api.baseUrl}/v1/front-end/verificationForCode';

    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: setHeaders());

    var res = jsonDecode(response.body);
    if (res['status']) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = User.fromJson(res['data']['user']);
      preferences.setBool('IsLoggedIn', true);
      preferences.setInt('id', user.id);
      preferences.setString('email', user.email);
      preferences.setString('first_name', user.first_name);
      preferences.setString('last_name', user.last_name);
      preferences.setString('image', user.image);
      preferences.setString('address', user.address);
      preferences.setString('created_at', user.created_at);
      preferences.setString('updated_at', user.updated_at);
      IsLoggedIn = true;
      EMAIL = user.email;
      FIRST_NAME = user.first_name;
      LAST_NAME = user.last_name;
      ADDRESS = user.address;
      IMAGE = user.image;
      ID = user.id;
    }
  }

  Future<bool> resendCode(data) async {
    final url = '${Api.baseUrl}/v1/front-end/reSendCode';

    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: setHeaders());

    var res = jsonDecode(response.body);
    if (res['status']) {
      return true;
    } else {
      return false;
    }
  }
}
