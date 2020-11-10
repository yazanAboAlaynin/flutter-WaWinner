import 'package:flutter_wawinner/models/campaign.dart';

class CartItem {
  Campaign campaign;
  int qty;
  int total_price;

  CartItem({this.campaign, this.qty, this.total_price});

  static CartItem fromJson(dynamic json) {
    return CartItem(
        campaign: Campaign.fromJson(json['campaign']),
        qty: json['qty'],
        total_price: json['total_price']);
  }

  static Map<String, dynamic> toMap(CartItem c) {
    var d = {
      'campaign': Campaign.toMap(c.campaign),
      'qty': c.qty,
      'total_price': c.total_price,
    };

    return d;
  }

  static List<Map> encodeCartItems(List<CartItem> items) =>
      items.map<Map<String, dynamic>>((item) => CartItem.toMap(item)).toList();
}
