class Order {
  final int id;
  final int order_no;
  final int transaction_no;
  final String status;

  Order({this.id, this.order_no, this.transaction_no, this.status});

  static Order fromJson(dynamic json) {
    return Order(
      transaction_no: json['transaction_no'],
      order_no: json['order_no'],
      id: json['id'],
      status: json['status'],
    );
  }
}
