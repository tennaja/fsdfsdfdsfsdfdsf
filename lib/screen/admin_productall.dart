import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/product_model.dart';
import 'package:project_bekery/model/producttype.dart';
import 'package:project_bekery/model/promotion_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/float_add_order.dart';
import 'package:project_bekery/script/firebaseapi.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project_bekery/widgets/adminAppbar.dart';

class admin_allproduct extends StatefulWidget {
  const admin_allproduct({Key? key}) : super(key: key);

  @override
  State<admin_allproduct> createState() => _admin_allproductState();
}

class _admin_allproductState extends State<admin_allproduct> {
  List<Product>? _product;

  @override
  void initState() {
    super.initState();
    _product = [];
    _getProduct('SELECT * from product');
  }

  _getProduct(sql) {
    print("function working");
    Art_Services().getProduct(sql).then((product) {
      setState(() {
        _product = product;
      });
      print("Length ${product.length}");
      print(_product![0].product_name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      appBar: SliderAppBar(
        drawerIconColor: Colors.white,
        trailing: PopupMenuButton(
          icon: Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
          ),
          onSelected: (value) {
            print('สถานะ : ${value.toString()}');
            _getProduct(value);
          },
          itemBuilder: (BuildContext bc) {
            return const [
              PopupMenuItem(
                child: Text("สินค้าใกล้หมด"),
                value: 'SELECT * FROM `product` ORDER BY product_quantity ASC',
              ),
              PopupMenuItem(
                child: Text("สินค้าขายดี"),
                value: 'SELECT * FROM `product` ORDER BY export_product DESC',
              ),
            ];
          },
        ),
        appBarHeight: 85,
        appBarColor: Color(0xFFbe95c4),
        title: Container(
          child: Center(
              child: const Text(
            'รายงานสินค้าในคลัง',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      slider: ComplexDrawer(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _product != null ? (_product?.length ?? 0) : 0,
              itemBuilder: (_, index) => Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 8.0),
                        child: Container(
                            child: Card(
                          elevation: 20,
                          color: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                leading: Image(
                                  image: NetworkImage(_product![index]
                                      .product_image
                                      .toString()),
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(
                                    'ชื่อสินค้า : ${_product![index].product_name}'),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'ขายไป : ${_product![index].export_product}'),
                                    Text(
                                        'เหลือในคลัง : ${_product![index].product_quantity}'),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return admin_productdetail(
                                        _product![index].product_id.toString(),
                                        _product![index]
                                            .product_name
                                            .toString(),
                                        _product![index]
                                            .product_detail
                                            .toString(),
                                        _product![index]
                                            .product_price
                                            .toString(),
                                        _product![index]
                                            .product_quantity
                                            .toString(),
                                        _product![index]
                                            .export_product
                                            .toString(),
                                        _product![index]
                                            .import_product
                                            .toString(),
                                        _product![index]
                                            .product_type_id
                                            .toString(),
                                        _product![index]
                                            .import_price
                                            .toString(),
                                        _product![index]
                                            .product_image
                                            .toString());
                                  }));
                                },
                              ),
                            ],
                          ),
                        )
                            /*ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            leading: Image(
                              image: NetworkImage(
                                  _product![index].product_image.toString()),
                              width: 50,
                              height: 50,
                            ),
                            title: Text(
                                'ชื่อสินค้า : ${_product![index].product_name}'),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'ขายไป : ${_product![index].export_product}'),
                                Text(
                                    'เหลือในคลัง : ${_product![index].product_quantity}'),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_productdetail(
                                    _product![index].product_id.toString(),
                                    _product![index].product_name.toString(),
                                    _product![index].product_detail.toString(),
                                    _product![index].product_price.toString(),
                                    _product![index].product_quantity.toString(),
                                    _product![index].export_product.toString(),
                                    _product![index].import_product.toString(),
                                    _product![index].product_type_id.toString(),
                                    _product![index].import_price.toString(),
                                    _product![index].product_image.toString());
                              }));
                            },
                          ),*/
                            ),
                      ),
                    ),
                  )),
        ),
      ),
    ));
  }
}

class admin_productdetail extends StatefulWidget {
  final String? product_id,
      product_name,
      product_detail,
      product_price,
      product_quantity,
      export_product,
      import_product,
      product_type_id,
      proudct_promotion,
      product_image;

  const admin_productdetail(
      this.product_id,
      this.product_name,
      this.product_detail,
      this.product_price,
      this.product_quantity,
      this.export_product,
      this.import_product,
      this.product_type_id,
      this.proudct_promotion,
      this.product_image,
      {Key? key})
      : super(key: key);

  @override
  State<admin_productdetail> createState() => _admin_productdetailState();
}

_UpdateProduct(product_id, product_name, product_detail, product_img,
    product_price, product_quantity, promotion) async {
  try {
    var url = Uri.parse('http://119.59.97.4/~web5/user_actions.php');
    print('funtion working....');
    var map = <String, dynamic>{};
    map["action"] = "ADD_PRODUCT";
    map['sql'] =
        "UPDATE product SET product_name='${product_name}',product_detail='${product_detail}',product_image='${product_img}',product_price='${product_price}',product_quantity='${product_quantity}',product_promotion='${promotion}' WHERE product_id = '${product_id}'";
    final response = await http.post(url, body: map);
    print("AddProduct >> Response:: ${response.body}");
    return response.body;
  } catch (e) {
    return 'error';
  }
}

_DeleteProduct(product_id) async {
  try {
    var url = Uri.parse('http://119.59.97.4/~web5/user_actions.php');
    print('funtion working....');
    var map = <String, dynamic>{};
    map["action"] = "ADD_PRODUCT";
    map['sql'] = "DELETE FROM `product` WHERE product_id = '${product_id}'";
    final response = await http.post(url, body: map);
    print("AddProduct >> Response:: ${response.body}");
    return response.body;
  } catch (e) {
    return 'error';
  }
}

class _admin_productdetailState extends State<admin_productdetail> {
  final fromKey = GlobalKey<FormState>();
  String? username, usersurname, useremail, userrole, userphone;
  UploadTask? task;
  File? image;
  String? product_name;
  String? product_detail;
  String? product_img;
  int? product_price;
  int? product_quantity;
  String selecttype = '';
  String dropdownValue = 'ประเภทข้าวสาร';
  String promotion = 'ไม่มีโปรโมชั่น';
  List<Promotion>? promotionlist;
  List<String> promotionnamelist = [];
  List<Producttype>? producttypelist;
  List<String> producttypenamelist = [];

  void initState() {
    super.initState();
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

  Future<void> uploadimage() async {
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
      product_img = urlDownload;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      promotion = widget.proudct_promotion.toString();
    });
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 50, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                width: 150,
                height: 35,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFbe95c4),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(100, 40), //////// HERE
                    ),
                    child: Text('อัปโหลดข้อมูล'),
                    onPressed: () async {
                      if (fromKey.currentState!.validate()) {
                        fromKey.currentState!.save();
                        print('Product_id : ${widget.product_id}');
                        print('Product_name : ${product_name}');
                        print('Product_detail : ${product_detail}');
                        print('Product_price : ${product_price}');
                        print('Product_quantity : ${product_quantity}');
                        print('Promotion : ${promotion}');
                        print('Promotion : ${image}');

                        if (image != null) {
                          uploadimage().then((value) => {
                                _UpdateProduct(
                                    widget.product_id,
                                    product_name,
                                    product_detail,
                                    product_img,
                                    product_price,
                                    product_quantity,
                                    promotion),
                                Fluttertoast.showToast(
                                    msg: "อัพเดตสำเร็จ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Color.fromARGB(255, 13, 255, 0),
                                    textColor: Colors.white,
                                    fontSize: 16.0),
                                Navigator.pop(context),
                              });
                        } else {
                          _UpdateProduct(
                              widget.product_id,
                              product_name,
                              product_detail,
                              widget.product_image,
                              product_price,
                              product_quantity,
                              promotion);
                          Fluttertoast.showToast(
                              msg: "อัพเดตสำเร็จ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color.fromARGB(255, 13, 255, 0),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return admin_allproduct();
                          }));
                        }
                      }
                    }),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                //background color of dropdown button
                border: Border.all(
                    color: Colors.white, width: 1), //border of dropdown button
                borderRadius: BorderRadius.circular(
                    30), //border raiuds of dropdown button
              ),
              child: SizedBox(
                width: 130,
                height: 35,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFbe95c4),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(100, 40), //////// HERE
                    ),
                    child: Text('ลบข้อมูลนี้'),
                    onPressed: () async {
                      _DeleteProduct(widget.product_id);
                      Fluttertoast.showToast(
                          msg: "ลบข้อมูลนี้สำเร็จ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 255, 0, 0),
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return admin_allproduct();
                      }));
                      /*uploadimage()*/
                    }),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFFbe95c4),
        elevation: 0,
        title: Center(
            child: const Text(
          'เพิ่มรายการสินค้า',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        )),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                          child: Image(
                            image:
                                NetworkImage(widget.product_image.toString()),
                          )),
                  SizedBox(
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 150,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFbe95c4),
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
                                content: const Text('เลือกวิธีการนำภาพออกมา'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      pickImage_carmera();
                                    },
                                    child: const Text("เลือกจากกล้องถ่าย"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      pickImage_filestore();
                                    },
                                    child: const Text("เลือกจากไฟล์ในมือถือ"),
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
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
                          onSaved: (name) {
                            product_name = name.toString();
                          },
                          autofocus: false,
                          initialValue: widget.product_name.toString(),
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            label: Text(
                              'ชื่อสินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
                          onSaved: (detail) {
                            product_detail = detail.toString();
                          },
                          autofocus: false,
                          initialValue: widget.product_detail.toString(),
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            label: Text(
                              'รายละเอียดสินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: TextFormField(
                                initialValue: widget.product_price.toString(),
                                style: TextStyle(color: Colors.white),
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                keyboardType: TextInputType.number,
                                onSaved: (price) {
                                  product_price = int.parse(price.toString());
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
                                  label: Text(
                                    'ราคา',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
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
                                initialValue:
                                    widget.product_quantity.toString(),
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  label: Text(
                                    'จำนวน',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
