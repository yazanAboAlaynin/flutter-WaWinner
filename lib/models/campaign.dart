import 'package:flutter_wawinner/models/product.dart';

import 'offer.dart';

class Campaign {
  final int id;
  final String max_draw_date;
  final int product_quantity;
  final int quantity_sold;
  final String status;
  final int ticket_count;
  final int donate_ticket_count;
  final int early_bird_count;
  final int early_bird_ticket_count;
  final int price;
  final String title;
  final String description;
  final Product product;
  final Product prize;
  bool isFavorite;
  List offers;

  Campaign(
      {this.id,
      this.max_draw_date,
      this.product_quantity,
      this.status,
      this.ticket_count,
      this.donate_ticket_count,
      this.early_bird_count,
      this.early_bird_ticket_count,
      this.price,
      this.product,
      this.prize,
      this.description,
      this.title,
      this.quantity_sold,
      this.isFavorite,
      this.offers});

  static Campaign fromJson(dynamic json) {
    var offers = json['offers'].map((dynamic i) => Offer.fromJson(i)).toList();
    return Campaign(
      id: json['id'],
      donate_ticket_count: json['donate_ticket_count'],
      early_bird_count: json['early_bird_count'],
      early_bird_ticket_count: json['early_bird_ticket_count'],
      max_draw_date: json['max_draw_date'],
      price: json['price'],
      prize: Product.fromJson(json['prize_id']),
      product: Product.fromJson(json['product_id']),
      product_quantity: json['product_quantity'],
      status: json['status'],
      ticket_count: json['ticket_count'],
      description: json['description'],
      title: json['title'],
      quantity_sold: json['quantity_sold'],
      isFavorite: json['isFavorite'] == 1 ? true : false,
      offers: offers,
    );
  }

  static Map<String, dynamic> toMap(Campaign c) {
    var d = {
      'id': c.id,
      'donate_ticket_count': c.donate_ticket_count,
      'early_bird_count': c.early_bird_count,
      'early_bird_ticket_count': c.early_bird_ticket_count,
      'max_draw_date': c.max_draw_date,
      'price': c.price,
      'prize_id': Product.toMap(c.prize),
      'product_id': Product.toMap(c.product),
      'status': c.status,
      'ticket_count': c.ticket_count,
      'description': c.description,
      'title': c.title,
      'quantity_sold': c.quantity_sold,
      'product_quantity': c.product_quantity,
      'added_to_wishlist': c.isFavorite,
      'offers': Offer.encodeOffers(c.offers),
    };

    return d;
  }

  static List<Map> encodeCampaigns(List<Campaign> items) =>
      items.map<Map<String, dynamic>>((item) => Campaign.toMap(item)).toList();
}
