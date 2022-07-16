// ignore_for_file: non_constant_identifier_names

class ProductModel {
  late String rice_name;
  late String rice_pice;
  late String rice_img;

  ProductModel(
      {required this.rice_name,
      required this.rice_pice,
      required this.rice_img});

  ProductModel.fromMap(Map<String, dynamic> data) {
    rice_name = data['rice_name'];
    rice_img = data['rice_img'];
    rice_pice = data['rice_pice'].double;
  }
}
