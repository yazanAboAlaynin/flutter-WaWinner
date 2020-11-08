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
}
