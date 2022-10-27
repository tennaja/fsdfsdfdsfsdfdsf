class User_mymaps {
  String? user_maps_id;
  String? user_email;
  String? user_maps_name;
  String? user_maps_detail;
  String? user_latitude;
  String? user_longitude;
  String? usermap_status;

  User_mymaps({
    required this.user_maps_id,
    required this.user_email,
    required this.user_maps_name,
    required this.user_maps_detail,
    required this.user_latitude,
    required this.user_longitude,
    required this.usermap_status,
  });

  factory User_mymaps.fromJson(Map<String, dynamic> json) {
    return User_mymaps(
      user_maps_id: json['user_maps_id'],
      user_email: json['user_email'],
      user_maps_name: json['user_maps_name'],
      user_maps_detail: json['user_maps_detail'],
      user_latitude: json['user_latitude'],
      user_longitude: json['user_longitude'],
      usermap_status: json['usermap_status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user_maps_id': user_maps_id,
        'user_email': user_email,
        'user_maps_name': user_maps_name,
        'user_maps_detail': user_maps_detail,
        'user_latitude': user_latitude,
        'user_longitude': user_longitude,
        'usermap_status': usermap_status,
      };
}
