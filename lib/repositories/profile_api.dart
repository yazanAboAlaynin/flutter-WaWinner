import 'dart:convert';

import 'package:flutter_wawinner/Constants.dart';
import 'package:flutter_wawinner/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import 'package:meta/meta.dart';

class ProfileApi extends Api {
  final http.Client httpClient;

  ProfileApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<User> profile() async {
    final url = '${Api.baseUrl}/v1/user/profile';

    final response = await this.httpClient.get(url, headers: getHeaders());

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
}
