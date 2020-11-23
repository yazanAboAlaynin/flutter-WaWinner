import 'dart:convert';

import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/product.dart';
import 'package:http/http.dart' as http;

import 'api.dart';
import 'package:meta/meta.dart';

class CampaignApi extends Api {
  final http.Client httpClient;

  CampaignApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Campaign>> getCampaigns() async {
    final url = '${Api.baseUrl}/v1/front-end/campaign';

    final response = await this.httpClient.get(url, headers: setHeaders());

    var res = jsonDecode(response.body)["data"] as List;

    List<Campaign> campaigns =
        res.map((dynamic i) => Campaign.fromJson(i)).toList();

    return campaigns;
  }

  Future<List<Product>> getProducts() async {
    final url = '${Api.baseUrl}/v1/front-end/product';

    final response = await this.httpClient.get(url, headers: setHeaders());

    var res = jsonDecode(response.body)["data"] as List;

    List<Product> products =
        res.map((dynamic i) => Product.fromJson(i)).toList();

    return products;
  }

  Future<List<String>> getImages() async {
    final url = '${Api.baseUrl}/v1/front-end/slider';

    final response = await this.httpClient.get(url, headers: setHeaders());

    var res = jsonDecode(response.body)["data"] as List;

    List<String> images = res.map((dynamic i) => i['image'] as String).toList();

    return images;
  }
}
