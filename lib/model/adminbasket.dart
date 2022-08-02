class Basket {
  String? basket_id;
  String? basket_product_id;
  String? basket_product_quantity;
  String? basket_product_pricetotal;
  String? product_id;
  String? product_name;
  String? product_detail;
  String? product_image;
  String? product_price;
  String? product_quantity;
  String? export_product;
  String? import_product;
  String? prouct_type_id;

  Basket(
      {required this.basket_id,
      required this.basket_product_id,
      required this.basket_product_quantity,
      required this.basket_product_pricetotal,
      required this.product_id,
      required this.product_name,
      required this.product_detail,
      required this.product_image,
      required this.product_price,
      required this.product_quantity,
      required this.export_product,
      required this.import_product,
      required this.prouct_type_id});

  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      basket_id: json['basket_id'],
      basket_product_id: json['basket_product_id'],
      basket_product_quantity: json['basket_product_quantity'],
      basket_product_pricetotal: json['basket_product_pricetotal'],
      product_id: json['product_id'],
      product_name: json['product_name'],
      product_detail: json['product_detail'],
      product_image: json['product_image'],
      product_price: json['product_price'],
      product_quantity: json['product_quantity'],
      export_product: json['export_product'],
      import_product: json['import_product'],
      prouct_type_id: json['prouct_type_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'basket_id': basket_id,
        'basket_product_id': basket_product_id,
        'basket_product_quantity': basket_product_quantity,
        'basket_product_pricetotal': basket_product_pricetotal,
        'product_id': product_id,
        'product_name': product_name,
        'product_detail': product_detail,
        'product_image': product_image,
        'product_price': product_price,
        'product_quantity': product_quantity,
        'export_product': export_product,
        'import_product': import_product,
        'prouct_type_id': prouct_type_id,
      };
}
