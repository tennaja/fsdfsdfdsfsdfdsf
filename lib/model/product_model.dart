class Product {
  String? product_id;
  String? product_name;
  String? product_detail;
  String? product_image;
  String? product_price;
  String? product_quantity;
  String? export_product;
  String? import_product;

  Product(
      {required this.product_id,
      required this.product_name,
      required this.product_detail,
      required this.product_image,
      required this.product_price,
      required this.product_quantity,
      required this.export_product,
      required this.import_product});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_id: json['product_id'],
      product_name: json['product_name'],
      product_detail: json['product_detail'],
      product_image: json['product_image'],
      product_price: json['product_price'],
      product_quantity: json['product_quantity'],
      export_product: json['export_product'],
      import_product: json['import_product'],
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': product_id,
        'product_name': product_name,
        'product_detail': product_detail,
        'product_image': product_image,
        'product_price': product_price,
        'product_quantity': product_quantity,
        'export_product': export_product,
        'import_product': import_product,
      };
}
