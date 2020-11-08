import 'package:flutter_wawinner/models/detail.dart';

class Product {
  final int id;
  final String is_prize;
  final String image;
  final String name;
  final String description;
  final String created_at;
  final String updated_at;
  final List detail;

  Product(
      {this.id,
      this.is_prize,
      this.image,
      this.name,
      this.description,
      this.created_at,
      this.updated_at,
      this.detail});

  static Product fromJson(dynamic json) {
    var detailes =
        json['detail'].map((dynamic i) => Detail.fromJson(i)).toList();
    return Product(
      id: json['id'],
      description: json['description'],
      detail: detailes,
      image: json['image'],
      is_prize: json['is_prize'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
