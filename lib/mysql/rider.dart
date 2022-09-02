class Rider {
  String rider_id;
  String rider_name;
  String rider_surname;
  String rider_phone;
  String rider_email;
  String rider_password;
  String? rider_latitude;
  String? rider_longitude;
  String rider_role;
  Rider(
      {required this.rider_id,
      required this.rider_name,
      required this.rider_surname,
      required this.rider_phone,
      required this.rider_email,
      required this.rider_latitude,
      required this.rider_longitude,
      required this.rider_password,
      required this.rider_role});

  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      rider_id: json['rider_id'] as String,
      rider_name: json['rider_name'] as String,
      rider_surname: json['rider_surname'] as String,
      rider_phone: json['rider_phone'] as String,
      rider_email: json['rider_email'] as String,
      rider_password: json['rider_password'] as String,
      rider_latitude: json['rider_latitude'],
      rider_longitude: json['rider_longitude'],
      rider_role: json['rider_role'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'rider_id': rider_id,
        'rider_name': rider_name,
        'rider_surname': rider_surname,
        'rider_phone': rider_phone,
        'rider_email': rider_email,
        'rider_email': rider_email,
        'rider_password': rider_password,
        'rider_laitiude': rider_latitude,
        'rider_longitude': rider_longitude,
        'rider_role': rider_role,
      };
}
