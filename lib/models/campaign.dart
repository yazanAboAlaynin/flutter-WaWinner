class Campaign {
  final String id;
  final String max_draw_date;
  final String product_quantity;
  final String status;
  final String ticket_count;
  final String donate_ticket_count;
  final String early_bird_count;
  final String early_bird_ticket_count;

  Campaign(
      {this.id,
      this.max_draw_date,
      this.product_quantity,
      this.status,
      this.ticket_count,
      this.donate_ticket_count,
      this.early_bird_count,
      this.early_bird_ticket_count});

  static Campaign fromJson(dynamic json) {
    return Campaign(
      id: json['id'],
    );
  }
}
