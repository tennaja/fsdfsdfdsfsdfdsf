import 'package:intl/intl.dart';

class Import_product {
  String? Import_order_id;
  String? Import_product_pricetotal;
  String? Import_date;
  String? Import_status;
  String? Import_source_id;
  String? source_id;
  String? source_name;
  String? source_number;
  String? source_address;

  Import_product({
    required this.Import_order_id,
    required this.Import_product_pricetotal,
    required this.Import_date,
    required this.Import_status,
    required this.Import_source_id,
    required this.source_id,
    required this.source_name,
    required this.source_number,
    required this.source_address,
  });

  factory Import_product.fromJson(Map<String, dynamic> json) {
    return Import_product(
      Import_order_id: json['Import_order_id'],
      Import_product_pricetotal: json['Import_product_pricetotal'],
      Import_date: json['Import_date'],
      Import_status: json['Import_status'],
      Import_source_id: json['Import_source_id'],
      source_id: json['source_id'],
      source_name: json['source_name'],
      source_number: json['source_number'],
      source_address: json['source_address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Import_order_id': Import_order_id,
        'Import_product_pricetotal': Import_product_pricetotal,
        'Import_date': Import_date,
        'Import_status': Import_status,
        'Import_source_id': Import_source_id,
        'source_id': source_id,
        'source_name': source_name,
        'source_number': source_number,
        'source_address': source_address,
      };
}
