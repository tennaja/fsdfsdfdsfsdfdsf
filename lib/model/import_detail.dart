class Import_detail {
  String? Import_order_id;
  String? Import_product_pricetotal;
  String? product_name;
  String? product_image;
  String? product_price;
  String? basket_product_quantity;
  String? basket_product_pricetotal;
  String? sumImport;

  Import_detail({
    required this.Import_order_id,
    required this.Import_product_pricetotal,
    required this.product_name,
    required this.product_image,
    required this.product_price,
    required this.basket_product_quantity,
    required this.basket_product_pricetotal,
    required this.sumImport,
  });

  factory Import_detail.fromJson(Map<String, dynamic> json) {
    return Import_detail(
      Import_order_id: json['Import_order_id'],
      Import_product_pricetotal: json['Import_product_pricetotal'],
      product_name: json['product_name'],
      product_image: json['product_image'],
      product_price: json['product_price'],
      basket_product_quantity: json['basket_product_quantity'],
      basket_product_pricetotal: json['basket_product_pricetotal'],
      sumImport: json['SUM(import_order_detail.basket_product_quantity)'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Import_order_id': Import_order_id,
        'Import_product_pricetotal': Import_product_pricetotal,
        'product_name': product_name,
        'product_image': product_image,
        'product_price': product_price,
        'basket_product_quantity': basket_product_quantity,
        'basket_product_pricetotal': basket_product_pricetotal,
      };
}
