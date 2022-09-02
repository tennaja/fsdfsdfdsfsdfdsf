class Promotion {
  String? promotion_id;
  String? promotion_name;
  String? promotion_value;

  Promotion({
    required this.promotion_id,
    required this.promotion_name,
    required this.promotion_value,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      promotion_id: json['promotion_id'],
      promotion_name: json['promotion_name'],
      promotion_value: json['promotion_value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'promotion_id': promotion_id,
        'promotion_name': promotion_name,
        'promotion_value': promotion_value,
      };
}
