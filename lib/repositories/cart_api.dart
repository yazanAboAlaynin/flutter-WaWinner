import 'dart:convert';

import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:http/http.dart' as http;

import '../Constants.dart';
import 'api.dart';
import 'package:meta/meta.dart';

class CartApi extends Api {
  final http.Client httpClient;

  CartApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future checkOut(List<CartItem> items, is_donated, coupon) async {
    final url = '${Api.baseUrl}/v1/user/take-order';
    List ids = [];
    List qtys = [];
    for (int i = 0; i < items.length; i++) {
      ids.add(items[i].campaign.id);
      qtys.add(items[i].qty);
    }
    var data = {
      'array_campaign_id': ids,
      'array_quantity_id': qtys,
      'is_donated': is_donated,
      'coupon': coupon
    };
    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: await getHeaders());

    var res = jsonDecode(response.body);
  }

  Future<bool> checkCoupon(data) async {
    final url = '${Api.baseUrl}/v1/front-end/check-coupon';
    final response = await this
        .httpClient
        .post(url, body: jsonEncode(data), headers: await getHeaders());

    var res = jsonDecode(response.body)['status'];

    if (res) {
      return true;
    } else
      return false;
  }
}
