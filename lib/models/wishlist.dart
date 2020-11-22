import 'dart:convert';
import 'package:flutter_wawinner/models/campaign.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cartItem.dart';

class WishList {
  static Future<List<Campaign>> getItems() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    if (!localStorage.containsKey('wishlist')) {
      return [];
    }

    var wl = jsonDecode(localStorage.get('wishlist')) as List;

    List<Campaign> items = wl.map((e) => Campaign.fromJson(e)).toList();

    return items;
  }

  static Future emptyWishList() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove('wishlist');
  }

  static Future<bool> addItem(Campaign item) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (!localStorage.containsKey('wishlist')) {
      localStorage.setString('wishlist', jsonEncode([]));
    }

    var wl = jsonDecode(localStorage.get('wishlist')) as List;

    List<Campaign> campaigns = wl.map((e) => Campaign.fromJson(e)).toList();
    bool t = true;
    for (int i = 0; i < campaigns.length; i++) {
      if (campaigns[i].id == item.id) {
        t = false;
        campaigns[i].added_to_wishlist = false;
        campaigns.removeAt(i);
      }
    }
    if (t) {
      campaigns.add(item);
      campaigns.last.added_to_wishlist = true;
    }

    List<Map> list = Campaign.encodeCampaigns(campaigns);

    localStorage.setString('wishlist', jsonEncode(list));

    return t;
  }

  static Future<bool> isInWL(id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (!localStorage.containsKey('wishlist')) {
      localStorage.setString('wishlist', jsonEncode([]));
    }

    var mds = jsonDecode(localStorage.get('wishlist')) as List;

    List<Campaign> campaigns = mds.map((e) => Campaign.fromJson(e)).toList();
    print(campaigns.length);
    for (int i = 0; i < campaigns.length; i++) {
      if (campaigns[i].id == id) {
        return true;
      }
    }

    return false;
  }

  static Future<void> addItemToCart(CartItem item) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (!localStorage.containsKey('cart')) {
      localStorage.setString('cart', jsonEncode([]));
    }

    var cart = jsonDecode(localStorage.get('cart')) as List;

    List<CartItem> campaigns = cart.map((e) => CartItem.fromJson(e)).toList();
    bool t = true;
    for (int i = 0; i < campaigns.length; i++) {
      if (campaigns[i].campaign.id == item.campaign.id) {
        t = false;
      }
    }
    if (t) campaigns.add(item);

    List<Map> list = CartItem.encodeCartItems(campaigns);

    localStorage.setString('cart', jsonEncode(list));
  }
}
