import 'package:intl/intl.dart';

class Export_product_detail {
  String? order_id;
  String? order_by;
  String? order_responsible_person;
  String? total_price;
  String? order_status;
  String? product_amount;
  String? product_name;
  String? product_image;
  String? product_price;

  Export_product_detail({
    required this.order_id,
    required this.order_by,
    required this.order_responsible_person,
    required this.total_price,
    required this.order_status,
    required this.product_amount,
    required this.product_name,
    required this.product_image,
    required this.product_price,
  });

  factory Export_product_detail.fromJson(Map<String, dynamic> json) {
    return Export_product_detail(
      order_id: json['order_id'],
      order_by: json['order_by'],
      order_responsible_person: json['order_responsible_person'],
      total_price: json['total_price'],
      order_status: json['order_status'],
      product_amount: json['product_amount'],
      product_name: json['product_name'],
      product_image: json['product_image'],
      product_price: json['product_price'],
    );
  }

  Map<String, dynamic> toJson() => {
        'order_id': order_id,
        'order_by': order_by,
        'order_responsible_person': order_responsible_person,
        'total_price': total_price,
        'order_status': order_status,
        'product_amount': product_amount,
        'product_name': product_name,
        'product_image': product_image,
        'product_price': product_price,
      };
}
