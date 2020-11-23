class User {
  int id;
  String email;
  String first_name;
  String last_name;
  String image;
  String address;
  String gender;
  String status;
  String nationality;
  String country_of_residence;
  String created_at;
  String updated_at;

  User({
    this.id,
    this.address,
    this.created_at,
    this.email,
    this.first_name,
    this.last_name,
    this.image,
    this.updated_at,
    this.country_of_residence,
    this.gender,
    this.nationality,
    this.status,
  });

  static User fromJson(dynamic json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      image: json['image'],
      address: json['address'],
      email: json['email'],
      status: json['status'],
      country_of_residence: json['country_of_residence'],
      gender: json['gender'],
      nationality: json['nationality'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
