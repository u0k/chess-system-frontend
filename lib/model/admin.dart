class Admin {
  String? username;
  String emailAddress;
  String? password;

  Admin({
    this.username,
    required this.emailAddress,
    this.password,
  });

  factory Admin.fromJson(dynamic json) {
    return Admin(
        username: json['username'] as String,
        emailAddress: json['emailAddress'] as String);
  }

    Map<String, dynamic> toJson() => {
        'username': username,
        'emailAddress': emailAddress,
        'password': password,
      };

}
