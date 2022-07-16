import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class Services {
  var url = Uri.parse('http://119.59.97.4/~web5/user_actions.php');
  static const _CRETE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const _ADD_USER_ORDER_ACTION = 'ADD_USER_ORDER';
  static const _ADD_PRODUCT_ACTION = 'ADD_PRODUCT';
  static const _ADD_ORDERDTAIL_ACTION = 'ADD_ORDERDETAIL';

  Future<String> addOrderdtail(
      order_id, product_id, product_amount, product_per_pice, total) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _ADD_ORDERDTAIL_ACTION;
      map["order_id"] = order_id;
      map["product_id"] = product_id;
      map["product_amount"] = product_amount;
      map["product_per_pice"] = product_per_pice;
      map["total"] = total;

      final response = await http.post(url, body: map);
      print("addOrderdtail >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error ${e}');
      return 'error';
    }
  }

  Future<String> addProduct(product_name, product_detail, product_image,
      product_price, export_product, import_product) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _ADD_PRODUCT_ACTION;
      map["product_name"] = product_name;
      map["product_detail"] = product_detail;
      map["product_image"] = product_image;
      map["product_price"] = product_price;
      map["export_product"] = export_product;
      map["import_product"] = import_product;
      final response = await http.post(url, body: map);
      print("addProduct >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> add_order(order_id, order_by, user_latitude, user_longitude,
      order_responsible_person, total_price, order_status) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _ADD_USER_ORDER_ACTION;
      map["order_id"] = order_id;
      map["order_by"] = order_by;
      map["user_latitude"] = user_latitude;
      map["user_longitude"] = user_longitude;
      map["order_responsible_person"] = order_responsible_person;
      map["total_price"] = total_price;
      map["order_status"] = order_status;
      final response = await http.post(url, body: map);
      print("add_order >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error : ${e}');
      return 'error';
    }
  }

  Future<List<User>> getUsers() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _GET_ALL_ACTION;
      final response = await http.post(url, body: map);
      print("getUsers >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parsePhotos(response.body);
        return list;
      } else {
        throw <User>[];
      }
    } catch (e) {
      return <User>[];
    }
  }

  static List<User> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  Future<String> createTable() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _CRETE_TABLE_ACTION;
      final response = await http.post(url, body: map);
      print("createTable >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> addUser(String user_name, String user_surname,
      String user_phone, String user_email, String user_password) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _ADD_EMP_ACTION;
      map["user_name"] = user_name;
      map["user_surname"] = user_surname;
      map["user_phone"] = user_phone;
      map["user_email"] = user_email;
      map["user_password"] = user_password;
      final response = await http.post(url, body: map);
      print("addUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> updateUser(
      String user_id,
      String user_name,
      String user_surname,
      String user_phone,
      String user_email,
      String user_password) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _UPDATE_EMP_ACTION;
      map["user_id"] = user_id;
      map["user_name"] = user_name;
      map["user_surname"] = user_surname;
      map["user_phone"] = user_phone;
      map["user_email"] = user_email;
      map["user_password"] = user_password;
      final response = await http.post(url, body: map);
      print("deleteUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deleteUser(String user_id) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _DELETE_EMP_ACTION;
      map["user_id"] = user_id;
      final response = await http.post(url, body: map);
      print("deleteUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}
