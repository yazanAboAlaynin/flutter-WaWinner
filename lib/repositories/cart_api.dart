import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api.dart';
import 'package:meta/meta.dart';

class CartApi extends Api {
  final http.Client httpClient;

  CartApi({
    @required this.httpClient,
  }) : assert(httpClient != null);
}
