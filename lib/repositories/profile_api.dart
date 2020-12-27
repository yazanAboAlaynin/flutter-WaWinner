import 'dart:convert';

import 'package:flutter_wawinner/Constants.dart';
import 'package:flutter_wawinner/models/currency.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meta/meta.dart';

import 'api.dart';

class ProfileApi extends Api {
  final http.Client httpClient;

  ProfileApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<User> profile() async {
    final url = '${Api.baseUrl}/v1/user/profile';

    final response =
        await this.httpClient.get(url, headers: await getHeaders());

    var res = jsonDecode(response.body);

    if (res['status']) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = User.fromJson(res['data']);

      preferences.setInt('id', user.id);

      preferences.setString('email', user.email);
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
      return user;
    } else {
      return null;
    }
  }

  Future updateProfile(data) async {
    final url = '${Api.baseUrl}/v1/user/updateProfile';

    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: await getHeaders());

    var res = jsonDecode(response.body);
    print(res);

    if (res['status']) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = User.fromJson(res['data']);

      preferences.setInt('id', user.id);

      preferences.setString('email', user.email);
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
      return user;
    } else {
      return null;
    }
  }

  Future<bool> changePassword(data) async {
    final url = '${Api.baseUrl}/v1/front-end/change-password';

    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: await getHeaders());

    var res = jsonDecode(response.body);
    if (res['status']) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> contactUs(data) async {
    final url = '${Api.baseUrl}/v1/front-end/contact-us';

    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: await getHeaders());

    var res = jsonDecode(response.body);
    if (res['status']) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> aboutUs() async {
    final url = '${Api.baseUrl}/v1/front-end/about-us';

    final response =
        await this.httpClient.get(url, headers: await getHeaders());

    var res = jsonDecode(response.body);
    String text = res['data'][0]['text'];
    return text;
  }

  Future<List<Currency>> currences() async {
    final url = '${Api.baseUrl}/v1/front-end/currencie';

    final response =
        await this.httpClient.get(url, headers: await getHeaders());

    var res = jsonDecode(response.body)['data'] as List;
    List<Currency> c = res.map((e) => Currency.fromJson(e)).toList();
    return c;
  }
}
