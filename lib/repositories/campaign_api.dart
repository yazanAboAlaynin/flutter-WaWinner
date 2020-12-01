import 'dart:convert';

import 'package:flutter_wawinner/models/campaign.dart';
import 'package:flutter_wawinner/models/charity.dart';
import 'package:flutter_wawinner/models/product.dart';
import 'package:flutter_wawinner/models/wishlist.dart';
import 'package:http/http.dart' as http;

import '../Constants.dart';
import 'api.dart';
import 'package:meta/meta.dart';

class CampaignApi extends Api {
  final http.Client httpClient;

  CampaignApi({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Campaign>> getCampaigns() async {
    final url = '${Api.baseUrl}/v1/front-end/campaign';

    final response =
        await this.httpClient.get(url, headers: await getHeaders());

    var res = jsonDecode(response.body)["data"] as List;

    List<Campaign> campaigns =
        res.map((dynamic i) => Campaign.fromJson(i)).toList();

    for (int i = 0; i < campaigns.length; i++) {
      bool x = await WishList.isInWL(campaigns[i].id);
      if (campaigns[i].isFavorite && !x) {
        await WishList.addItem(campaigns[i]);
      }
      if (!campaigns[i].isFavorite && x) {
        await WishList.addItem(campaigns[i]);
      }
    }
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

  Future<List<Charity>> getCharities() async {
    final url = '${Api.baseUrl}/v1/front-end/charity';

    final response = await this.httpClient.get(url, headers: setHeaders());

    var res = jsonDecode(response.body)["data"] as List;

    List<Charity> charity =
        res.map((dynamic i) => Charity.fromJson(i)).toList();

    return charity;
  }

  Future<List<String>> getImages() async {
    final url = '${Api.baseUrl}/v1/front-end/slider';

    final response = await this.httpClient.get(url, headers: setHeaders());

    var res = jsonDecode(response.body)["data"] as List;

    List<String> images = res.map((dynamic i) => i['image'] as String).toList();

    return images;
  }
}
