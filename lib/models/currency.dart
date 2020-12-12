class Currency {
  String name;
  String value;

  Currency({this.name, this.value});
  static Currency fromJson(dynamic json) {
    return Currency(
      name: json['currency'],
      value: json['currency'],
    );
  }
}
