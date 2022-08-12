class User_Basket {
  String? user_basket_id;
  String? user_basket_product_id;
  String? user_basket_quantity;
  String? user_basket_pricetotal;
  String? user_basket_email;
  String? product_id;
  String? product_name;
  String? product_detail;
  String? product_image;
  String? product_price;
  String? product_quantity;
  String? export_product;
  String? import_product;
  String? prouct_type_id;

  User_Basket(
      {required this.user_basket_id,
      required this.user_basket_product_id,
      required this.user_basket_quantity,
      required this.user_basket_pricetotal,
      required this.user_basket_email,
      required this.product_id,
      required this.product_name,
      required this.product_detail,
      required this.product_image,
      required this.product_price,
      required this.product_quantity,
      required this.export_product,
      required this.import_product,
      required this.prouct_type_id});

  factory User_Basket.fromJson(Map<String, dynamic> json) {
    return User_Basket(
      user_basket_id: json['user_basket_id'],
      user_basket_product_id: json['user_basket_product_id'],
      user_basket_quantity: json['user_basket_quantity'],
      user_basket_pricetotal: json['user_basket_pricetotal'],
      user_basket_email: json['user_basket_email'],
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
        'user_basket_id': user_basket_id,
        'user_basket_product_id': user_basket_product_id,
        'user_basket_quantity': user_basket_quantity,
        'user_basket_pricetotal': user_basket_pricetotal,
        'user_basket_email': user_basket_email,
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
