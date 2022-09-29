// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors, must_be_immutable, camel_case_types, avoid_unnecessary_containers, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/model/producttype.dart';
import 'package:project_bekery/model/promotion_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/order_rice_sql.dart';
import 'package:project_bekery/script/firebaseapi.dart';
import 'package:project_bekery/model/product.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';
import 'package:uuid/uuid.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:http/http.dart' as http;

class add_product_order extends StatefulWidget {
  const add_product_order({Key? key}) : super(key: key);

  @override
  _add_product_orderState createState() => _add_product_orderState();
}

_AddProduct(
    product_name,
    product_detail,
    product_img,
    product_price,
    product_quantity,
    export_product,
    import_product,
    producttype,
    improt_price1) async {
  try {
    var url = Uri.parse('https://artfinalproject.000webhostapp.com/');
    print('funtion working....');
    var map = <String, dynamic>{};
    map["action"] = "ADD_PRODUCT";
    map['sql'] =
        "INSERT INTO product(product_name, product_detail, product_image, product_price, product_quantity, export_product, import_product, product_type_id, import_price) VALUES ('${product_name}','${product_detail}','${product_img}',${product_price},${product_quantity},0,0,'${producttype}','${improt_price1}')";
    final response = await http.post(url, body: map);
    print("AddProduct >> Response:: ${response.body}");
    return response.body;
  } catch (e) {
    return 'error';
  }
}

class _add_product_orderState extends State<add_product_order> {
  final fromKey = GlobalKey<FormState>();
  UploadTask? task;
  File? image;
  String? product_name;
  String? product_detail;
  String? product_img;
  int? product_price;
  int? product_quantity;
  int? improt_price;
  String selecttype = '';
  String dropdownValue = 'ไม่ได้ระบุ';
  String promotion = 'ไม่มีโปรโมชั่น';
  List<Promotion>? promotionlist;
  List<String> promotionnamelist = [];
  List<Producttype>? producttypelist;
  List<String> producttypenamelist = [];
  List<Producttype> producttypeidlist = [];

  void initState() {
    super.initState();
    promotionlist = [];
    _getProduct();
  }

  _getProduct() {
    print("function working");
    Art_Services().getall_promotion().then((promotion) {
      setState(() {
        promotionlist = promotion;
      });
      print("Length ${promotion.length}");
      print(promotionlist![0].promotion_name);
      for (var i = 0; i < promotion.length; i++) {
        setState(() {
          promotionnamelist.insert(i, '${promotionlist![i].promotion_name}');
        });
      }
      print('promotionnamelist : ${promotionnamelist}');
    });
    Art_Services().getall_producttype().then((producttype) {
      setState(() {
        producttypelist = producttype;
      });
      for (var i = 0; i < producttype.length; i++) {
        setState(() {
          producttypenamelist.insert(
              i, '${producttypelist![i].product_type_name}');
        });
      }
      print('promotionnamelist : ${producttypenamelist}');
    });
  }

  Future pickImage_carmera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed : $e');
    }
  }

  Future pickImage_filestore() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed : $e');
    }
  }

  Future<void> uploadimage(product_name, product_detail, product_price1,
      product_quantity1, improt_price1) async {
    String? producttype;

    Art_Services().getonly_producttype(dropdownValue).then((value) {
      setState(() {
        producttypeidlist = value;
      });
    }).then((value) {
      setState(() {
        producttype = producttypeidlist[0].product_type_id;
      });
    });
    int i = 0;
    if (image == null) return;
    final filename = basename(image!.path);
    final imagede = 'product_image/$filename';
    task = FirebaseApi.uploadfile(imagede, image!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download url : $urlDownload');
    setState(() {
      product_img = urlDownload.toString();
      product_price = product_price1;
      product_quantity = product_quantity1;
    });
    _AddProduct(product_name, product_detail, product_img, product_price,
        product_quantity, 0, 0, producttype, improt_price1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SliderDrawer(
          appBar: SliderAppBar(
            appBarHeight: 85,
            appBarColor: Color(0xFF6411ad),
            title: Container(
              child: Center(
                  child: const Text(
                'เพิ่มสินค้า',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          slider: ComplexDrawer(),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colorz.complexDrawerBlack,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: fromKey,
                  child: Container(
                    child: Column(
                      children: [
                        image != null
                            ? Image.file(
                                image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset('assets/images/upload.png'),
                              ),
                        SizedBox(
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          width: 150,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF6411ad),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              minimumSize: Size(100, 40), //////// HERE
                            ),
                            child: Text('อัปโหลดรูปภาพ'),
                            onPressed: () {
                              showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('อัพโหลดภาพ'),
                                      content:
                                          const Text('เลือกวิธีการนำภาพออกมา'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            pickImage_carmera();
                                          },
                                          child:
                                              const Text("เลือกจากกล้องถ่าย"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            pickImage_filestore();
                                          },
                                          child: const Text(
                                              "เลือกจากไฟล์ในมือถือ"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                onSaved: (name) {
                                  product_name = name.toString();
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  label: Text('ชื่อสินค้า',
                                      style: TextStyle(color: Colors.white)),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                onSaved: (detail) {
                                  product_detail = detail.toString();
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  label: Text('รายละเอียดสินค้า',
                                      style: TextStyle(color: Colors.white)),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    child: TextFormField(
                                      validator: RequiredValidator(
                                          errorText: "กรุณาป้อนข้อมูล"),
                                      keyboardType: TextInputType.number,
                                      onSaved: (price) {
                                        product_price =
                                            int.parse(price.toString());
                                      },
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        label: Text('ราคา (ที่จะขาย)',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: TextFormField(
                                      validator: RequiredValidator(
                                          errorText: "กรุณาป้อนข้อมูล"),
                                      keyboardType: TextInputType.number,
                                      onSaved: (quantity) {
                                        product_quantity =
                                            int.parse(quantity.toString());
                                      },
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        label: Text('จำนวน',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    child: TextFormField(
                                      validator: RequiredValidator(
                                          errorText: "กรุณาป้อนข้อมูล"),
                                      keyboardType: TextInputType.number,
                                      onSaved: (importprice) {
                                        improt_price =
                                            int.parse(importprice.toString());
                                      },
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
                                        label: Text('ราคา (ที่ซื้อมา)',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  //background color of dropdown button
                                  border: Border.all(
                                    color: Colors.white,
                                  ), //border of dropdown button
                                  borderRadius: BorderRadius.circular(
                                      30), //border raiuds of dropdown button
                                ),
                                child: DropdownButton(
                                  dropdownColor: Colorz.complexDrawerBlack,
                                  value: dropdownValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  // ignore: prefer_const_literals_to_create_immutables

                                  items: producttypenamelist
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(
                                        width: 200, // for example
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(value,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  icon: Padding(
                                      //Icon at tail, arrow bottom is default icon
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_downward)),
                                  iconEnabledColor: Color.fromARGB(
                                      255, 255, 253, 253), //Icon color

                                  //dropdown background color
                                  underline: Container(), //remove underline
                                  isExpanded:
                                      true, //make true to make width 100%
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 30,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  //background color of dropdown button
                                  border: Border.all(
                                      color: Colors.black38,
                                      width: 1), //border of dropdown button
                                  borderRadius: BorderRadius.circular(
                                      30), //border raiuds of dropdown button
                                ),
                                child: SizedBox(
                                  width: 300,
                                  height: 35,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF6411ad),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        minimumSize:
                                            Size(100, 40), //////// HERE
                                      ),
                                      child: Text('อัปโหลดข้อมูล'),
                                      onPressed: () async {
                                        if (fromKey.currentState!.validate()) {
                                          if (image == null) {
                                            Fluttertoast.showToast(
                                                msg: "กรุณาเพิ่มรูปภาพก่อน",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Color.fromARGB(
                                                    255, 255, 0, 0),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else {
                                            fromKey.currentState!.save();
                                            await uploadimage(
                                                    product_name,
                                                    product_detail,
                                                    product_price,
                                                    product_quantity,
                                                    improt_price)
                                                .then((value) => {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "เพิ่มสินค้าเรียบร้อย",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  13,
                                                                  255,
                                                                  0),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0),
                                                      Navigator.pop(context),
                                                    });
                                          }
                                        }
                                        /*uploadimage()*/
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
