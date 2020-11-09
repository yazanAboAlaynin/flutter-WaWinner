import 'dart:convert';
import 'package:flutter_wawinner/models/cartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart {
  static Future<List<CartItem>> getItems() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (!localStorage.containsKey('cart')) {
      return [];
    }

    var cart = jsonDecode(localStorage.get('cart')) as List;

    List<CartItem> items = cart.map((e) => CartItem.fromJson(e)).toList();

    return items;
  }

  static Future<int> getItemsNumber() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (!localStorage.containsKey('cart')) {
      return 0;
    }

    var cart = jsonDecode(localStorage.get('cart')) as List;

    List<CartItem> items = cart.map((e) => CartItem.fromJson(e)).toList();

    return items.length;
  }

  static Future emptyCart() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove('cart');
  }

  static Future<void> addItem(CartItem item) async {
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

  static Future<void> deleteItem(id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var mds = jsonDecode(localStorage.get('cart')) as List;

    List<CartItem> campaigns = mds.map((e) => CartItem.fromJson(e)).toList();

    for (int i = 0; i < campaigns.length; i++) {
      if (campaigns[i].campaign.id == id) {
        campaigns.removeAt(i);
      }
    }

    List<Map> list = CartItem.encodeCartItems(campaigns);
    localStorage.setString('cart', jsonEncode(list));
  }

  static Future<void> increase(id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (!localStorage.containsKey('cart')) {
      return;
    }

    var cart = jsonDecode(localStorage.get('cart')) as List;

    List<CartItem> campaigns = cart.map((e) => CartItem.fromJson(e)).toList();

    for (int i = 0; i < campaigns.length; i++) {
      if (campaigns[i].campaign.id == id) {
        // if (medicines[i].quantity < medicines[i].distributer.max) {
        campaigns[i].qty++;
        // }
        break;
      }
    }
    List<Map> list = CartItem.encodeCartItems(campaigns);
    localStorage.setString('cart', jsonEncode(list));
  }

  static Future<void> decrease(id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (!localStorage.containsKey('cart')) {
      return;
    }

    var cart = jsonDecode(localStorage.get('cart')) as List;

    List<CartItem> campaigns = cart.map((e) => CartItem.fromJson(e)).toList();

    for (int i = 0; i < campaigns.length; i++) {
      if (campaigns[i].campaign.id == id) {
        // if (campaigns[i].qty > campaigns[i].distributer.min)
        campaigns[i].qty--;
        break;
        // }
      }
      List<Map> list = CartItem.encodeCartItems(campaigns);
      localStorage.setString('cart', jsonEncode(list));
    }
  }
}
