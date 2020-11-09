import 'package:flutter_wawinner/models/product.dart';

class Campaign {
  final int id;
  final String max_draw_date;
  final String product_quantity;
  final String quantity_sold;
  final String status;
  final String ticket_count;
  final String donate_ticket_count;
  final String early_bird_count;
  final String early_bird_ticket_count;
  final String original_price;
  final double price_after_vat;
  final double price_displayed_by_currency;
  final String title;
  final String description;
  final Product product;
  final Product prize;

  Campaign(
      {this.id,
      this.max_draw_date,
      this.product_quantity,
      this.status,
      this.ticket_count,
      this.donate_ticket_count,
      this.early_bird_count,
      this.early_bird_ticket_count,
      this.original_price,
      this.price_after_vat,
      this.price_displayed_by_currency,
      this.product,
      this.prize,
      this.description,
      this.title,
      this.quantity_sold});

  static Campaign fromJson(dynamic json) {
    return Campaign(
        id: json['id'],
        donate_ticket_count: json['donate_ticket_count'],
        early_bird_count: json['early_bird_count'],
        early_bird_ticket_count: json['early_bird_ticket_count'],
        max_draw_date: json['max_draw_date'],
        original_price: json['original_price'],
        price_after_vat: json['price_after_vat'],
        price_displayed_by_currency: json['price_displayed_by_currency'],
        prize: Product.fromJson(json['prize_id']),
        product: Product.fromJson(json['product_id']),
        product_quantity: json['product_quantity'],
        status: json['status'],
        ticket_count: json['ticket_count'],
        description: json['description'],
        title: json['title'],
        quantity_sold: json['quantity_sold']);
  }

  static Map<String, dynamic> toMap(Campaign c) {
    var d = {
      'id': c.id,
      'donate_ticket_count': c.donate_ticket_count,
      'early_bird_count': c.early_bird_count,
      'early_bird_ticket_count': c.early_bird_ticket_count,
      'max_draw_date': c.max_draw_date,
      'original_price': c.original_price,
      'price_after_vat': c.price_after_vat,
      'price_displayed_by_currency': c.price_displayed_by_currency,
      'prize_id': Product.toMap(c.prize),
      'product_id': Product.toMap(c.product),
      'status': c.status,
      'ticket_count': c.ticket_count,
      'description': c.description,
      'title': c.title,
      'quantity_sold': c.quantity_sold,
    };

    return d;
  }

  static List<Map> encodeCampaigns(List<Campaign> items) =>
      items.map<Map<String, dynamic>>((item) => Campaign.toMap(item)).toList();
}
