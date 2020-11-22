import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:http/http.dart' as http;

import 'api.dart';
import 'package:meta/meta.dart';

class WLApi extends Api {
  final http.Client httpClient;

  WLApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future addToWishlist(id) async {
    final url =
        '${Api.baseUrl}/v1/user/toggle-campaign-in-wish-list?campaign_id=$id';

    final response = await this.httpClient.get(url, headers: getHeaders());

    var res = jsonDecode(response.body);
  }

  Future<List<Campaign>> getItems() async {
    final url = '${Api.baseUrl}/v1/user/fetch-wish-list-to-user';

    final response = await this.httpClient.get(url, headers: getHeaders());
    if (jsonDecode(response.body)['status']) {
      var res = jsonDecode(response.body)['data'] as List;
      List<Campaign> items = res.map((e) => Campaign.fromJson(e)).toList();
      return items;
    } else
      return [];
  }
}
