class Producttype {
  String? product_type_id;
  String? product_type_name;

  Producttype({
    required this.product_type_id,
    required this.product_type_name,
  });

  factory Producttype.fromJson(Map<String, dynamic> json) {
    return Producttype(
      product_type_id: json['product_type_id'],
      product_type_name: json['product_type_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'product_type_id': product_type_id,
        'product_type_name': product_type_name,
      };
}
