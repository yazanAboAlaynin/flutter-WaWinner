import 'dart:convert';

import 'package:flutter_wawinner/models/campaign.dart';
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

  Future<List<Campaign>> getProducts() async {
    final url = '${Api.baseUrl}/v1/front-end/campaign';

    final response = await this.httpClient.get(url, headers: setHeaders());

    var res = jsonDecode(response.body)["data"] as List;

    List<Campaign> campaigns =
        res.map((dynamic i) => Campaign.fromJson(i)).toList();

    return campaigns;
  }
}
