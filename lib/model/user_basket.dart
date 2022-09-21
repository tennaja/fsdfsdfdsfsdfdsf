class User_Basket {
  String? user_basket_id;
  String? user_basket_product_id;
  String? product_name;
  String? user_basket_quantity;
  String? user_basket_price;
  String? user_basket_email;
  String? basket_product_promotionname;
  String? basket_product_promotionvalue;
  String? simpletotal;
  String? discount;
  String? totalprice;
  String? product_image;

  User_Basket({
    required this.user_basket_id,
    required this.user_basket_product_id,
    required this.product_name,
    required this.user_basket_quantity,
    required this.user_basket_price,
    required this.user_basket_email,
    required this.basket_product_promotionname,
    required this.basket_product_promotionvalue,
    required this.simpletotal,
    required this.discount,
    required this.totalprice,
    required this.product_image,
  });

  factory User_Basket.fromJson(Map<String, dynamic> json) {
    return User_Basket(
      user_basket_id: json['user_basket_id'],
      user_basket_product_id: json['user_basket_product_id'],
      product_name: json['product_name'],
      user_basket_quantity: json['user_basket_quantity'],
      user_basket_price: json['user_basket_price'],
      user_basket_email: json['user_basket_email'],
      basket_product_promotionname: json['basket_product_promotionname'],
      basket_product_promotionvalue: json['basket_product_promotionvalue'],
      simpletotal: json['simpletotal'],
      discount: json['discount'],
      totalprice: json['totalprice'],
      product_image: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user_basket_id': user_basket_id,
        'user_basket_product_id': user_basket_product_id,
        'product_name': product_name,
        'user_basket_quantity': user_basket_quantity,
        'user_basket_price': user_basket_price,
        'user_basket_email': user_basket_email,
        'basket_product_promotionname': basket_product_promotionname,
        'basket_product_promotionvalue': basket_product_promotionvalue,
        'simpletotal': simpletotal,
        'discount': discount,
        'totalprice': totalprice,
        'product_image': product_image,
      };
}
