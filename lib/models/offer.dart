class Offer {
  final int id;
  final int product_limit;
  final int extra_ticket_count;

  Offer({this.id, this.product_limit, this.extra_ticket_count});

  static Offer fromJson(dynamic json) {
    return Offer(
      id: json['id'],
      product_limit: json['product_limit'],
      extra_ticket_count: json['extra_ticket_count'],
    );
  }

  static Map<String, dynamic> toMap(Offer c) {
    var d = {
      'id': c.id,
      'extra_ticket_count': c.extra_ticket_count,
      'product_limit': c.product_limit,
    };

    return d;
  }

  static List<Map> encodeOffers(List items) =>
      items.map<Map<String, dynamic>>((item) => Offer.toMap(item)).toList();
}
