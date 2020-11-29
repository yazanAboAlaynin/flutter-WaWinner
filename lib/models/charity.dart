class Charity {
  final int id;
  final String title;
  final String image;
  final String url;
  final String description;

  Charity({this.id, this.title, this.image, this.url, this.description});

  static Charity fromJson(dynamic json) {
    return Charity(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      url: json['url'],
      description: json['description'],
    );
  }
}
