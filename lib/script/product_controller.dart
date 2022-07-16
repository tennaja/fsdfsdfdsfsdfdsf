import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_bekery/model/product.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  static RxList<ProductModel> products = RxList<ProductModel>();
  String collection = "rice";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      FirebaseFirestore.instance.collection("rice").snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}
