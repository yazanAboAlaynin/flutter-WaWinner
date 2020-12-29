class Ticket {
  final int id;
  final String title;
  final String description;
  final String image;
  final String quantity;
  final List<String> codes;

  Ticket(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.quantity,
      this.codes});

  static Ticket fromJson(dynamic json) {
    var tickets = json['tikets'].map((dynamic i) => i['code']).toList();
    return Ticket(
      id: json['campaign']['id'],
      description: json['campaign']['description'],
      image: json['campaign']['image'],
      codes: tickets,
      quantity: json['campaign']['quantity'],
      title: json['campaign']['title'],
    );
  }
}
