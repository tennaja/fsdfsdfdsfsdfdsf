import 'package:intl/intl.dart';

class Export_product {
  String? order_id;
  String? order_by;
  String? user_latitude;
  String? user_longitude;
  String? order_responsible_person;
  String? total_price;
  String? order_status;
  String? date;
  String? product_amount;
  String? user_name;
  String? user_surname;

  Export_product({
    required this.order_id,
    required this.order_by,
    required this.user_latitude,
    required this.user_longitude,
    required this.order_responsible_person,
    required this.total_price,
    required this.order_status,
    required this.date,
    required this.product_amount,
    required this.user_name,
    required this.user_surname,
  });

  factory Export_product.fromJson(Map<String, dynamic> json) {
    return Export_product(
      order_id: json['order_id'],
      order_by: json['order_by'],
      user_latitude: json['user_latitude'],
      user_longitude: json['user_longitude'],
      order_responsible_person: json['order_responsible_person'],
      total_price: json['total_price'],
      order_status: json['order_status'],
      date: json['order_date'],
      product_amount: json['product_amount'],
      user_name: json['user_name'],
      user_surname: json['user_surname'],
    );
  }

  Map<String, dynamic> toJson() => {
        'order_id': order_id,
        'order_by': order_by,
        'user_latitude': user_latitude,
        'user_longitude': user_longitude,
        'order_responsible_person': order_responsible_person,
        'total_price': total_price,
        'order_status': order_status,
        'date': date,
        'product_amount': product_amount,
      };
}
