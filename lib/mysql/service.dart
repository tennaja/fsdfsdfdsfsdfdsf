import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_bekery/model/adminbasket.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/model/import_detail.dart';
import 'package:project_bekery/model/import_product.dart';
import 'package:project_bekery/model/product_model.dart';
import 'package:project_bekery/model/product_promotion.dart';
import 'package:project_bekery/model/producttype.dart';
import 'package:project_bekery/model/promotion_model.dart';
import 'package:project_bekery/model/user_basket.dart';
import 'package:project_bekery/model/userlog.dart';
import 'package:project_bekery/mysql/rider.dart';
import '../model/source_model.dart';
import '../model/user_maps.dart';
import 'user.dart';

class Art_Services {
  var url = Uri.parse('https://projectart434.000webhostapp.com/');
  static const _CRETE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const _ADD_USER_ORDER_ACTION = 'ADD_USER_ORDER';
  static const _ADD_PRODUCT_ACTION = 'ADD_PRODUCT';
  static const _ADD_ORDERDTAIL_ACTION = 'ADD_ORDERDETAIL';

  Future<String> update_map_user(latitude, longitude, where) async {
    try {
      print(
          '--------------------------update_map------------------------------');
      var map = <String, dynamic>{};
      map["action"] = "UPDATE_MAP_USER";
      map["latitude"] = latitude;
      map["longitude"] = longitude;
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("update_map_user >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> update_map_rider(latitude, longitude, where) async {
    try {
      print(
          '--------------------------update_map------------------------------');
      var map = <String, dynamic>{};
      map["action"] = "UPDATE_MAP_RIDER";
      map["latitude"] = latitude;
      map["longitude"] = longitude;
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("update_map_rider >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> addOrderdtail(order_id, product_id, product_amount,
      product_per_pice, product_promotion_name, product_promotion_value) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _ADD_ORDERDTAIL_ACTION;
      map["order_id"] = order_id;
      map["product_id"] = product_id;
      map["product_amount"] = product_amount;
      map["product_per_pice"] = product_per_pice;
      map["product_promotion_name"] = product_promotion_name;
      map["product_promotion_value"] = product_promotion_value;

      final response = await http.post(url, body: map);
      print("addOrderdtail >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error ${e}');
      return 'error';
    }
  }

  Future<String> add_importproduct(
      Import_order_id, Import_totalprice, DateTime, source_id) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "_ADD_IMPORTPRODUCT";
      map["Import_order_id"] = Import_order_id;
      map["Import_totalprice"] = Import_totalprice;
      map["DateTime"] = DateTime;
      map["source_id"] = source_id;

      final response = await http.post(url, body: map);
      print("add_importproduct >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error ${e}');
      return 'error';
    }
  }

  Future<String> add_source(sourcename, sourceaddress, sourcephone) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "_ADD_SOURCE";
      map["sourcename"] = sourcename;
      map["sourceaddress"] = sourceaddress;
      map["sourcephone"] = sourcephone;

      final response = await http.post(url, body: map);
      print("add_source >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error ${e}');
      return 'error';
    }
  }

  Future<String> add_promotion(promotion_name, promotion_value) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "_ADD_PROMPTION";
      map["promotion_name"] = promotion_name;
      map["promotion_value"] = promotion_value;

      final response = await http.post(url, body: map);
      print("add_promotion >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error ${e}');
      return 'error';
    }
  }

  Future<String> add_producttype(producttype_name) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "_ADD_PRODUCTTYPE";
      map["producttype_name"] = producttype_name;

      final response = await http.post(url, body: map);
      print("add_producttype >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error ${e}');
      return 'error';
    }
  }

  Future<String> add_product_promotion(where1, where2, where3, where4) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ADD_PRODUCT_PROMOTION";
      map["product_id"] = where1; // rideremail
      map["promotion_id"] = where2; // status
      map["start_date"] = where3;
      map["end_date"] = where4; // orderid
      final response = await http.post(url, body: map);
      print("add_product_promotion >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> add_importproduct_detail(Import_order_id, basket_product_id,
      basket_product_quantity, basket_product_pricetotal, DateTime) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "_ADD_IMPORTPRODUCT_DETAIL";
      map["Import_order_id"] = Import_order_id;
      map["basket_product_id"] = basket_product_id;
      map["basket_product_quantity"] = basket_product_quantity;
      map["basket_product_pricetotal"] = basket_product_pricetotal;
      map["DateTime"] = DateTime;

      final response = await http.post(url, body: map);
      print("add_importproduct_detail >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error ${e}');
      return 'error';
    }
  }

  Future<String> add_order(
      order_id,
      order_by,
      user_latitude,
      user_longitude,
      order_responsible_person,
      total_price,
      order_status,
      date,
      product_amount) async {
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
      map["date"] = date;
      map["product_amount"] = product_amount;
      final response = await http.post(url, body: map);
      print("add_order >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error : ${e}');
      return 'error';
    }
  }

  Future<String> add_order_import(import_order_id, import_order_by,
      import_order_total, import_order_date, import_order_status) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ADD_IMPORT_ORDER";
      map["import_order_id"] = import_order_id;
      map["import_order_by"] = import_order_by;
      map["import_order_total"] = import_order_total;
      map["import_order_date"] = import_order_date;
      map["import_order_status"] = import_order_status;
      final response = await http.post(url, body: map);
      print("add_order_import >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error : ${e}');
      return 'error';
    }
  }

  Future<String> import_producttobasket(basket_product_id,
      basket_product_quantity, basket_product_price, source_id) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ADD_BASKET";
      print('product ID --------> ${basket_product_id}');
      map["basket_product_id"] = basket_product_id.toString();
      map["basket_product_quantity"] = basket_product_quantity.toString();
      var totalprice = int.parse(basket_product_price.toString()) *
          int.parse(basket_product_quantity.toString());
      map["basket_product_pricetotal"] = totalprice.toString();
      map["source_id"] = source_id.toString();

      final response = await http.post(url, body: map);
      print("import_producttobasket >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error : ${e}');
      return 'error';
    }
  }

  Future<String> user_add_basket(
      basket_product_id,
      basket_product_quantity,
      basket_product_price,
      email,
      basket_product_promotionname,
      basket_product_promotionvalue) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ADD_USER_BASKET";
      print('product ID --------> ${basket_product_id}');
      print('product quantity --------> ${basket_product_quantity}');
      print('product price --------> ${basket_product_price}');
      print('email --------> ${email}');
      print(
          'basket_product_promotionname --------> ${basket_product_promotionname}');
      print(
          'basket_product_promotionvalue --------> ${basket_product_promotionvalue}');
      map["basket_product_id"] = basket_product_id.toString();
      map["basket_product_quantity"] = basket_product_quantity;
      map["basket_product_price"] = basket_product_price;
      map["email"] = email.toString();
      map["basket_product_promotionname"] =
          basket_product_promotionname.toString();
      map["basket_product_promotionvalue"] = basket_product_promotionvalue;

      final response = await http.post(url, body: map);
      print("user_add_basket >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      print('error : ${e}');
      return 'error';
    }
  }

  Future<List<User>> getUsers(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _GET_ALL_ACTION;
      map["where"] = where;

      final response = await http.post(url, body: map);
      print("getUsers >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parseResponse(response.body);

        return list;
      } else {
        print("getUsers >> Response:: ${response.statusCode}");
        throw <User>[];
      }
    } catch (e) {
      print(e);
      return <User>[];
    }
  }

  Future<List<User>> getonlyUser(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = 'GET_ONLY_USER';
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getUsers >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parseResponse(response.body);

        return list;
      } else {
        print("getUsers >> Response:: ${response.statusCode}");
        throw <User>[];
      }
    } catch (e) {
      print(e);
      return <User>[];
    }
  }

  Future<List<User>> getonlyUserMap(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = 'GET_ONLY_USER_MAP';
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getUsers >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parseResponse(response.body);

        return list;
      } else {
        print("getUsers >> Response:: ${response.statusCode}");
        throw <User>[];
      }
    } catch (e) {
      print(e);
      return <User>[];
    }
  }

  Future<List<Rider>> getonlyRider(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = 'GET_ONLY_RIDER';
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getonlyRider >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Rider> list = parseResponseRider(response.body);

        return list;
      } else {
        print("getonlyRider >> Response:: ${response.statusCode}");
        throw <Rider>[];
      }
    } catch (e) {
      print(e);
      return <Rider>[];
    }
  }

  Future<List<Rider>> getallRider() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = 'GET_ALL_RIDER';
      final response = await http.post(url, body: map);
      print("getallRider >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Rider> list = parseResponseRider(response.body);

        return list;
      } else {
        print("getallRider >> Response:: ${response.statusCode}");
        throw <Rider>[];
      }
    } catch (e) {
      print(e);
      return <Rider>[];
    }
  }

  static List<Rider> parseResponseRider(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Rider>((json) => Rider.fromJson(json)).toList();
  }

  Future<List<User>> geyonlyuser(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = 'GET_ONLY_USER';
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("geyonlyuser >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parseResponse(response.body);

        return list;
      } else {
        print("geyonlyuser >> Response:: ${response.statusCode}");
        throw <User>[];
      }
    } catch (e) {
      print(e);
      return <User>[];
    }
  }

  Future<List<User>> Loginuser(useremail, password) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = '_LOGIN_ACTION';
      map["useremail"] = useremail;
      map["password"] = password;

      final response = await http.post(url, body: map);
      print("Loginuser >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        print("Loginuser >> Response:: ${response.statusCode}");
        throw <User>[];
      }
    } catch (e) {
      print(e);
      return <User>[];
    }
  }

  Future<List<Rider>> Loginrider(useremail, password) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = 'RIDER_LOGIN_ACTION';
      map["useremail"] = useremail;
      map["password"] = password;

      final response = await http.post(url, body: map);
      print("Loginrider >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Rider> list = parseResponseRider(response.body);
        return list;
      } else {
        print("Loginrider >> Response:: ${response.statusCode}");
        throw <Rider>[];
      }
    } catch (e) {
      print(e);
      return <Rider>[];
    }
  }

  Future<List<Product>> getProduct(sql) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ALL_PRODUCT";
      map["sql"] = sql;
      final response = await http.post(url, body: map);
      print("getProduct >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Product> list = parseResponseProduct(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Product>[];
      }
    } catch (e) {
      print(e);
      return <Product>[];
    }
  }

  Future<List<Product>> getonlyProduct(where) async {
    try {
      var map = <String, dynamic>{};
      print('${where}');
      map["action"] = "GET_ONLY_PRODUCT";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getonlyProduct >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Product> list = parseResponseProduct(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Product>[];
      }
    } catch (e) {
      print(e);
      return <Product>[];
    }
  }

  Future<List<source>> getSource() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ALL_SOURCE";
      final response = await http.post(url, body: map);
      print("getSource >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<source> list = parseResponsesource(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <source>[];
      }
    } catch (e) {
      print(e);
      return <source>[];
    }
  }

  Future<List<source>> getonlySource(
      sourcename, sourceaddress, sourcephone) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ONLY_SOURCE";
      map["sourcename"] = sourcename;
      map["sourceaddress"] = sourceaddress;
      map["sourcephone"] = sourcephone;

      final response = await http.post(url, body: map);
      print("getonlySource >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<source> list = parseResponsesource(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <source>[];
      }
    } catch (e) {
      print(e);
      return <source>[];
    }
  }

  Future<List<Basket>> getadminbasket(source_id) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ADMIN_BASKET";
      map["where"] = source_id;
      final response = await http.post(url, body: map);
      print("getadminbasket >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Basket> list = parseResponsebasket(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Basket>[];
      }
    } catch (e) {
      print(e);
      return <Basket>[];
    }
  }

  Future<List<User_Basket>> getuserbasket(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_USER_BASKET";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getuserbasket >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User_Basket> list = parseResponseuserbasket(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <User_Basket>[];
      }
    } catch (e) {
      print(e);
      return <User_Basket>[];
    }
  }

  Future<List<User_Basket>> checkuserbasket(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "CHECK_USER_BASKET";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("checkuserbasket >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User_Basket> list = parseResponseuserbasket(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <User_Basket>[];
      }
    } catch (e) {
      print(e);
      return <User_Basket>[];
    }
  }

  static List<User_Basket> parseResponseuserbasket(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<User_Basket>((json) => User_Basket.fromJson(json))
        .toList();
  }

  Future<List<User_mymaps>> getusermaps(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_USER_MAPS";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getusermaps >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User_mymaps> list = parseResponseusermaps(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <User_mymaps>[];
      }
    } catch (e) {
      print(e);
      return <User_mymaps>[];
    }
  }

  Future<List<User_mymaps>> getlocation(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_USER_LOCATION";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getlocation >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User_mymaps> list = parseResponseusermaps(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <User_mymaps>[];
      }
    } catch (e) {
      print(e);
      return <User_mymaps>[];
    }
  }

  static List<User_mymaps> parseResponseusermaps(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<User_mymaps>((json) => User_mymaps.fromJson(json))
        .toList();
  }

  Future<List<Import_product>> getimport_product(where) async {
    try {
      var map = <String, dynamic>{};
      print('Where : ${where}');
      map["action"] = "GET_IMPORT_PRODUCT";
      map["where"] = where;
      print(where);
      final response = await http.post(url, body: map);
      print("getimport_product >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Import_product> list = parseResponseImport_product(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Import_product>[];
      }
    } catch (e) {
      print(e);
      return <Import_product>[];
    }
  }

  Future<List<Import_detail>> getimport_detail(String where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_IMPORT_PRODUCTDETAI";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getimport_detail >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Import_detail> list = parseResponseImport_detail(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Import_detail>[];
      }
    } catch (e) {
      print(e);
      return <Import_detail>[];
    }
  }

  Future<List<Export_product_detail>> getuserorder_detail(String where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_USER_PRODUCTDETAI";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getuser_detail >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Export_product_detail> list =
            parseResponseuserorder_detail(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Export_product_detail>[];
      }
    } catch (e) {
      print(e);
      return <Export_product_detail>[];
    }
  }

  static List<Export_product_detail> parseResponseuserorder_detail(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Export_product_detail>(
            (json) => Export_product_detail.fromJson(json))
        .toList();
  }

  Future<List<Logstatus>> getuserlog(String where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_USER_LOG";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getuserlog >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Logstatus> list = parseResponseuseruserlog(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Logstatus>[];
      }
    } catch (e) {
      print(e);
      return <Logstatus>[];
    }
  }

  static List<Logstatus> parseResponseuseruserlog(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Logstatus>((json) => Logstatus.fromJson(json)).toList();
  }

  Future<List<Export_product>> gatallExport_product(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_EXPORT_PRODUCT";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("gatallproduct >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Export_product> list = parseResponseexport_product(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Export_product>[];
      }
    } catch (e) {
      print(e);
      return <Export_product>[];
    }
  }

  Future<List<Export_product>> gatonlyExport_product(
      where, order_status) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ONLY_EXPORT_PRODUCT";
      map["where"] = where;
      map["order_status"] = order_status;
      final response = await http.post(url, body: map);
      print("gatonlyExport_product >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Export_product> list = parseResponseexport_product(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Export_product>[];
      }
    } catch (e) {
      print(e);
      return <Export_product>[];
    }
  }

  Future<List<Export_product>> rider_getExport_product(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "RIDER_GET_EXPORT_PRODUCT";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("rider_getExport_product >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Export_product> list = parseResponseexport_product(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Export_product>[];
      }
    } catch (e) {
      print(e);
      return <Export_product>[];
    }
  }

  Future<List<Export_product>> rider_getonlyExport_product(
      where, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "RIDER_GET_ONLYEXPORT_PRODUCT";
      map["where"] = where;
      map["where2"] = where2;
      final response = await http.post(url, body: map);
      print("rider_getonlyExport_product >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Export_product> list = parseResponseexport_product(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Export_product>[];
      }
    } catch (e) {
      print(e);
      return <Export_product>[];
    }
  }

  Future<List<Export_product>> rider_getlocation_order(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "RIDER_GET_LOCATION_ORDER";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("rider_getlocation_order >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Export_product> list = parseResponseexport_product(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Export_product>[];
      }
    } catch (e) {
      print(e);
      return <Export_product>[];
    }
  }

  Future<List<Export_product_detail>> getorder_detail(String where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ORDER_DETAIL";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getproduct_detail >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Export_product_detail> list =
            parseResponseorder_detail(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Export_product_detail>[];
      }
    } catch (e) {
      print(e);
      return <Export_product_detail>[];
    }
  }

  Future<List<Export_product_detail>> getorderonly_detail(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ORDER_ONLY_DETAIL";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getorderonly_detail >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Export_product_detail> list =
            parseResponseorder_detail(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Export_product_detail>[];
      }
    } catch (e) {
      print(e);
      return <Export_product_detail>[];
    }
  }

  static List<Export_product_detail> parseResponseorder_detail(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Export_product_detail>(
            (json) => Export_product_detail.fromJson(json))
        .toList();
  }

  static List<Export_product> parseResponseexport_product(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Export_product>((json) => Export_product.fromJson(json))
        .toList();
  }

  static List<Import_detail> parseResponseImport_detail(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Import_detail>((json) => Import_detail.fromJson(json))
        .toList();
  }

  static List<Import_product> parseResponseImport_product(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Import_product>((json) => Import_product.fromJson(json))
        .toList();
  }

  static List<Basket> parseResponsebasket(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Basket>((json) => Basket.fromJson(json)).toList();
  }

  static List<source> parseResponsesource(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<source>((json) => source.fromJson(json)).toList();
  }

  static List<Product> parseResponseProduct(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  static List<User> parseResponse(String responseBody) {
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

  Future<String> addrider(String user_name, String user_surname,
      String user_phone, String user_email, String user_password) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = 'ADD_RIDER';
      map["user_name"] = user_name;
      map["user_surname"] = user_surname;
      map["user_phone"] = user_phone;
      map["user_email"] = user_email;
      map["user_password"] = user_password;
      final response = await http.post(url, body: map);
      print("addrider >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> AddProduct(
      product_name,
      product_detail,
      product_img,
      product_price,
      product_quantity,
      export_product,
      import_product,
      producttype,
      promotion) async {
    try {
      print('funtion working....');
      var map = <String, dynamic>{};
      map["action"] = "ADD_PRODUCT";
      map["product_name"] = product_name;
      map["product_detail"] = product_detail;
      map["product_img"] = product_img;
      map["product_price"] = product_price;
      map["product_quantity"] = product_quantity;
      map["export_product"] = export_product;
      map["import_product"] = import_product;
      map["producttype"] = producttype;
      map["promotion"] = promotion;
      print(
          'value : $product_name,$product_detail,$product_img,$product_price,$product_quantity,$export_product,$import_product,$producttype,$promotion');
      final response = await http.post(url, body: map);
      print("AddProduct >> Response:: ${response.body}");
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
      print("updateUser >> Response:: ${response.body}");
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

  Future<String> deletesource(String source_id) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = 'DELETE_SOURCE';
      map["where"] = source_id;
      final response = await http.post(url, body: map);
      print("deleteUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deletebasket() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETE_BASKET";
      final response = await http.post(url, body: map);
      print("deletebasket >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deleteuserbasket(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETE_USER_BASKET";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("deleteuserbasket >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deleteonlybasket(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETE_ONLY_BASKET";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("deleteonlybasket >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deleteorder(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETE_ORDER";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("deleteorder >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deleteorderdetail(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETE_ORDERDETAIL";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("deleteorderdetail >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> submit_order(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ORDER_SUBMIT";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("submit_order >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> update_user(
      user_id, username, usersurname, useremail, userrole, userphone) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "UPDATE_USER";
      map["where"] = user_id;
      map["username"] = username;
      map["usersurname"] = usersurname;
      map["useremail"] = useremail;
      map["userrole"] = userrole;
      map["userphone"] = userphone;
      final response = await http.post(url, body: map);
      print("update_user >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> update_rider(rider_id, ridername, ridersurname, rideremail,
      riderrole, riderphone) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "UPDATE_RIDER";
      map["where"] = rider_id;
      map["ridername"] = ridername;
      map["ridersurname"] = ridersurname;
      map["rideremail"] = rideremail;
      map["riderrole"] = riderrole;
      map["riderphone"] = riderphone;
      final response = await http.post(url, body: map);
      print("update_rider >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> rider_update_order(where1, where2, where3) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "RIDER_UPDATE_ORDER";
      map["where"] = where1; // rideremail
      map["where2"] = where2; // status
      map["where3"] = where3; // orderid
      final response = await http.post(url, body: map);
      print("rider_update_order >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> product_quantity_update(where1, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "PRODUCT_QUANTITY_UPDATE";
      map["where"] = where1; // rideremail
      map["where2"] = where2; // status
      // orderid
      final response = await http.post(url, body: map);
      print("product_quantity_update >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> Import_product_quantity_update(where1, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "IMPORT_PRODUCT_QUANTITY_UPDATE";
      map["where"] = where1; // rideremail
      map["where2"] = where2; // status
      // orderid
      final response = await http.post(url, body: map);
      print("Import_product_quantity_update >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> add_user_maps(user_email, user_maps_name, user_maps_detail,
      user_latitude, user_longitude) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ADD_USER_MAPS";
      map["user_email"] = user_email; // rideremail
      map["user_maps_name"] = user_maps_name;
      map["user_maps_detail"] = user_maps_detail;
      map["user_latitude"] = user_latitude;
      map["user_longitude"] = user_longitude; // status
      // orderid
      final response = await http.post(url, body: map);
      print("add_user_maps >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> cancel_order(where1) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "CANCLE_ORDER";
      map["where"] = where1; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("product_quantity_update >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return '${e}';
    }
  }

  Future<String> accept_order(where1) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ACCEPT_ORDER";
      map["where"] = where1; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("accept_order >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return '${e}';
    }
  }

  Future<String> acceptpackge_order(where1) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ACCEPTPACKGE_ORDER";
      map["where"] = where1; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("acceptpackge_order >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return '${e}';
    }
  }

  Future<String> waitcancel_order(where1, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "WAITCANCEL_ORDER";
      map["where"] = where1;
      map["where2"] = where2; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("waitcancel_order >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return '${e}';
    }
  }

  Future<List<Import_detail>> getallimport_detail() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ALL_IMPORT_PRODUCTDETAI";
      final response = await http.post(url, body: map);
      print("getallimport_detail >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Import_detail> list = parseResponseImport_detail(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Import_detail>[];
      }
    } catch (e) {
      print(e);
      return <Import_detail>[];
    }
  }

  static List<Promotion> parseResponseall_promotion(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Promotion>((json) => Promotion.fromJson(json)).toList();
  }

  Future<List<Promotion>> getonly_promotion(where, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GETONLY_PROMOTION";
      map["where"] = where;
      map["where2"] = where2;
      final response = await http.post(url, body: map);
      print("getonly_promotion >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Promotion> list = parseResponseall_promotion(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Promotion>[];
      }
    } catch (e) {
      print(e);
      return <Promotion>[];
    }
  }

  Future<List<Promotion>> getonly_promotionbyname(where) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GETONLY_PROMOTION_BYNAME";
      map["where"] = where;
      final response = await http.post(url, body: map);
      print("getonly_promotionbyname >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Promotion> list = parseResponseall_promotion(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Promotion>[];
      }
    } catch (e) {
      print(e);
      return <Promotion>[];
    }
  }

  Future<List<Promotion>> getall_promotion() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GETALL_PROMOTION";
      final response = await http.post(url, body: map);
      print("getall_promotion >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Promotion> list = parseResponseall_promotion(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Promotion>[];
      }
    } catch (e) {
      print(e);
      return <Promotion>[];
    }
  }

  Future<List<Producttype>> getall_producttype() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GETALL_PRODUCTTYPE_1";
      final response = await http.post(url, body: map);
      print("getall_producttype >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Producttype> list = parseResponseall_producttype(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Producttype>[];
      }
    } catch (e) {
      print(e);
      return <Producttype>[];
    }
  }

  Future<List<Producttype>> getonly_producttype(where1) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GETONLY_PRODUCTTYPE_1";
      map["where"] = where1;
      final response = await http.post(url, body: map);
      print("getonly_producttype >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Producttype> list = parseResponseall_producttype(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Producttype>[];
      }
    } catch (e) {
      print(e);
      return <Producttype>[];
    }
  }

  Future<List<Producttype>> getonly_producttypename(where1) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GETONLY_PRODUCTTYPE_2";
      map["where"] = where1;
      final response = await http.post(url, body: map);
      print("getonly_producttypename >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Producttype> list = parseResponseall_producttype(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Producttype>[];
      }
    } catch (e) {
      print(e);
      return <Producttype>[];
    }
  }

  static List<Producttype> parseResponseall_producttype(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Producttype>((json) => Producttype.fromJson(json))
        .toList();
  }

  Future<String> changeuserpassword(where1, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "CHANGE_USERPASSWORD";
      map["where"] = where1;
      map["where2"] = where2; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("product_quantity_update >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> changeriderpassword(where1, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "CHANGE_RIDERPASSWORD";
      map["where"] = where1;
      map["where2"] = where2; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("changeriderpassword >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deleteproducttype(where1) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETEPRODUCTTYPE";
      map["where"] = where1; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("deleteproducttype >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> adduserlog(log_status, log_userid, log_date) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "ADD_USER_LOGS";
      map["log_status"] = log_status;
      map["log_userid"] = log_userid;
      map["log_date"] = log_date; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("adduserlog >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> editproducttype(where1, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "EDITPRODUCTTYPE";
      map["where"] = where1;
      map["where2"] = where2; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("editproducttype >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> editsource(
      where1, sourcename, sourceaddress, sourcephone) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "EDITSOURCE";
      map["where"] = where1;
      map["sourcename"] = sourcename;
      map["sourceaddress"] = sourceaddress;
      map["sourcephone"] = sourcephone;
      // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("editproducttype >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deletepromotion(where1) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETEPROMOTION";
      map["where"] = where1; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("deleteproducttype >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> deleteproduct_promotion(product_id, promotion_id) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETEPRODUCTPROMOTION";
      map["product_id"] = product_id;
      map["promotion_id"] = promotion_id; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("deleteproduct_promotion >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> editpromotion(where1, where2, where3) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "EDITPROMOTION";
      map["where"] = where1;
      map["where2"] = where2;
      map["where3"] = where3; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("editproducttype >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<List<Product_promotion>> getall_product_promotion() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ALL_PRODUCT_PROMOTION";
      final response = await http.post(url, body: map);
      print("getall_product_promotion >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Product_promotion> list =
            parseResponseproduct_promotion(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Product_promotion>[];
      }
    } catch (e) {
      print(e);
      return <Product_promotion>[];
    }
  }

  Future<List<Product_promotion>> getonly_product_promotion(
      where1, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ONLY_PRODUCT_PROMOTION";
      map["where"] = where1;
      map["where2"] = where2;
      final response = await http.post(url, body: map);
      print("getall_product_promotion >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Product_promotion> list =
            parseResponseproduct_promotion(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Product_promotion>[];
      }
    } catch (e) {
      print(e);
      return <Product_promotion>[];
    }
  }

  Future<List<Product_promotion>> getonlyvalue_product_promotion(
      where1, where2) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ONLYVALUE_PRODUCT_PROMOTION";
      map["where"] = where1;
      map["where2"] = where2;
      final response = await http.post(url, body: map);
      print("getall_product_promotion >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Product_promotion> list =
            parseResponseproduct_promotion(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Product_promotion>[];
      }
    } catch (e) {
      print(e);
      return <Product_promotion>[];
    }
  }

  Future<List<Product_promotion>> getonly_product_promotion_status(
      where1, where2, where3) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "GET_ONLY_PRODUCT_PROMOTION_STATUS";
      map["where"] = where1;
      map["where2"] = where2;
      map["where3"] = where3;
      final response = await http.post(url, body: map);
      print("getonly_product_promotion_status >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Product_promotion> list =
            parseResponseproduct_promotion(response.body);
        print("---------------------------------------------");
        return list;
      } else {
        print("statusCode >> Response:: ${response.statusCode}");
        throw <Product_promotion>[];
      }
    } catch (e) {
      print(e);
      return <Product_promotion>[];
    }
  }

  static List<Product_promotion> parseResponseproduct_promotion(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Product_promotion>((json) => Product_promotion.fromJson(json))
        .toList();
  }

  Future<String> deleteusermap(usermapsid) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "DELETEUSERMAP";
      map["where"] = usermapsid; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("deleteusermap >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> editusermap(
      usermapsid, user_maps_name, user_maps_detail) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "EDITUSERMAP";
      map["where"] = usermapsid;
      map["user_maps_name"] = user_maps_name;
      map["user_maps_detail"] = user_maps_detail; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("editusermap >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> updatestatususermap(usermapsid, usermap_status) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "UPDATE_STATUS_USERMAP";
      map["where"] = usermapsid;
      map["usermap_status"] = usermap_status; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("updatestatususermap >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> updatestatususermapall(useremail) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = "UPDATE_STATUS_USERMAPALL";
      map["where"] = useremail;
      map["usermap_status"] = 'ยังไม่ถูกใช้งาน'; // rideremail // status
      // orderid
      final response = await http.post(url, body: map);
      print("updatestatususermap >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}
