class User {
  int? id;
  String? username;
  String? emailAddress;
  String? password;
  int? currency;

  User({
    this.id,
    this.username,
    this.emailAddress,
    this.password,
    this.currency,
  });

  factory User.fromJson(dynamic json) {
    return User(
        username: json['username']  == null ? null : json['username'] as String,
        emailAddress: json['emailAddress']  == null ? null : json['emailAddress'] as String,
        currency: json['currency']  == null ? null : json['currency'] as int,
        password: json['password'] == null ? null : json['password'] as String,
        id: json['id'] == null ? null : json['id'] as int
        );
  }

    Map<String, dynamic> toJson() => {
        'username': username,
        'emailAddress': emailAddress,
        'password': password,
      };

}
