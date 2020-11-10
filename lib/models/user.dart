class User {
  int id;
  String email;
  String name;
  String address;
  String created_at;
  String updated_at;

  User(
      {this.id,
      this.address,
      this.created_at,
      this.email,
      this.name,
      this.updated_at});

  static User fromJson(dynamic json) {
    return User(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
