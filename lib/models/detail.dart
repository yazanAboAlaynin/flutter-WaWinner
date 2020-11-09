class Detail {
  final int id;
  final String product_id;
  final String title;
  final String value;
  final String created_at;
  final String updated_at;

  Detail(
      {this.id,
      this.product_id,
      this.title,
      this.value,
      this.created_at,
      this.updated_at});

  static Detail fromJson(dynamic json) {
    return Detail(
      id: json['id'],
      product_id: json['product_id'],
      title: json['title'],
      value: json['value'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  static Map<String, dynamic> toMap(Detail c) {
    var d = {
      'id': c.id,
      'product_id': c.product_id,
      'title': c.title,
      'value': c.value,
      'created_at': c.created_at,
      'updated_at': c.updated_at,
    };

    return d;
  }

  static List<Map> encodeDetailItems(List items) =>
      items.map<Map<String, dynamic>>((item) => Detail.toMap(item)).toList();
}
