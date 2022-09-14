import 'package:intl/intl.dart';

class Product_promotion {
  String? promotion_id;
  String? promotion_name;
  String? promotion_value;
  String? product_id;
  String? product_name;
  String? start_date;
  String? end_date;

  Product_promotion({
    required this.promotion_id,
    required this.promotion_name,
    required this.promotion_value,
    required this.product_id,
    required this.product_name,
    required this.start_date,
    required this.end_date,
  });

  factory Product_promotion.fromJson(Map<String, dynamic> json) {
    return Product_promotion(
      promotion_id: json['promotion_id'],
      promotion_name: json['promotion_name'],
      promotion_value: json['promotion_value'],
      product_id: json['product_id'],
      product_name: json['product_name'],
      start_date: json['start_date'],
      end_date: json['end_date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'promotion_id': promotion_id,
        'promotion_name': promotion_name,
        'promotion_value': promotion_value,
        'product_id': product_id,
        'product_name': product_name,
        'start_date': start_date,
        'end_date': end_date,
      };
}
