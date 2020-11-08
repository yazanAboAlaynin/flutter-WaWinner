import 'package:flutter_wawinner/models/detail.dart';

class Product {
  final String id;
  final String is_prize;
  final String image;
  final String name;
  final String description;
  final String created_at;
  final String updated_at;
  final List<Detail> detail;

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
    var detailes = json['detail']
        .map((dynamic i) => Detail.fromJson(i))
        .toList() as List<Detail>;
    return Product(
      id: json['id'],
      description: json['id'],
      detail: detailes,
      image: json['id'],
      is_prize: json['id'],
      name: json['id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
