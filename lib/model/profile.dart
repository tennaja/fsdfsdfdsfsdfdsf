// ignore_for_file: non_constant_identifier_names
class Profile {
  late String id;
  late String username;
  late String email;
  late String password;
  late String Role;
  late String u_latitude;
  late String u_longitude;

  Profile(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.Role,
      required this.u_latitude,
      required this.u_longitude});

  Profile.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    username = data['name'];
    email = data['email'];
    Role = data['Role'];
    u_latitude = data['u_latitude'];
    u_longitude = data['u_longitude'];
  }
}
