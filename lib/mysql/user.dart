class User {
  String user_id;
  String user_name;
  String user_surname;
  String user_phone;
  String user_email;
  String user_password;
  String? user_latitude;
  String? user_longitude;
  String user_role;
  User(
      {required this.user_id,
      required this.user_name,
      required this.user_surname,
      required this.user_phone,
      required this.user_email,
      required this.user_latitude,
      required this.user_longitude,
      required this.user_password,
      required this.user_role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'] as String,
      user_name: json['user_name'] as String,
      user_surname: json['user_surname'] as String,
      user_phone: json['user_phone'] as String,
      user_email: json['user_email'] as String,
      user_password: json['user_password'] as String,
      user_latitude: json['user_latitude'],
      user_longitude: json['user_longitude'],
      user_role: json['user_role'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'user_name': user_name,
        'user_surname': user_surname,
        'user_phone': user_phone,
        'user_email': user_email,
        'user_email': user_email,
        'user_password': user_password,
        'user_laitiude': user_latitude,
        'user_longitude': user_longitude,
        'user_role': user_role,
      };
}
