class Order {
  final int order_no;
  final int invoice_no;

  Order({this.order_no, this.invoice_no});

  static Order fromJson(dynamic json) {
    return Order(
      invoice_no: json['invoice_no'],
      order_no: json['order_no'],
    );
  }
}
