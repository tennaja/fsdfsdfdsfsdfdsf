import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/product_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/float_add_order.dart';
import 'package:project_bekery/script/firebaseapi.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('ออกจากระบบ'),
                      content: const Text('ต้องการที่จะออกจากระบบไหม?'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("ไม่"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                  builder: (context) => LoginPage()),
                              (_) => false,
                            );
                          },
                          child: const Text("ใช่"),
                        ),
                      ],
                    );
                  });
            },
          ),
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          title: Center(
              child: Text(
            'รายชื่อสินค้าในคลัง',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return add_product_order();
                    }));
                  },
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.black,
                  ),
                  onSelected: (value) {
                    print('สถานะ : ${value.toString()}');
                    _getProduct(value);
                  },
                  itemBuilder: (BuildContext bc) {
                    return const [
                      PopupMenuItem(
                        child: Text("สินค้าใกล้หมด"),
                        value:
                            'SELECT * FROM `product` ORDER BY product_quantity ASC',
                      ),
                      PopupMenuItem(
                        child: Text("สินค้าขายดี"),
                        value:
                            'SELECT * FROM `product` ORDER BY export_product DESC',
                      ),
                    ];
                  },
                )
              ],
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.orangeAccent.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _product != null ? (_product?.length ?? 0) : 0,
                itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
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
                          tileColor: Colors.orangeAccent,
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
                                  _product![index].product_promotion.toString(),
                                  _product![index].product_image.toString());
                            }));
                          },
                        ),
                      ),
                    )),
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
                      primary: Colors.orangeAccent,
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
                          Navigator.pop(context);
                        }
                      }
                    }),
              ),
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
                width: 150,
                height: 35,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
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
                      Navigator.pop(context);
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
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.orangeAccent.withOpacity(0.5),
        elevation: 0,
        title: Center(
            child: const Text(
          'เพิ่มรายการสินค้า',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        )),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.orangeAccent.withOpacity(0.5),
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
                        primary: Colors.orangeAccent,
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
                          decoration: InputDecoration(
                            label: Text('ชื่อสินค้า'),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
                          onSaved: (detail) {
                            product_detail = detail.toString();
                          },
                          autofocus: false,
                          initialValue: widget.product_detail.toString(),
                          decoration: InputDecoration(
                            label: Text('รายละเอียดสินค้า'),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: TextFormField(
                                initialValue: widget.product_price.toString(),
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                keyboardType: TextInputType.number,
                                onSaved: (price) {
                                  product_price = int.parse(price.toString());
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  label: Text('ราคา'),
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
                                decoration: InputDecoration(
                                  label: Text('จำนวน'),
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
                        DecoratedBox(
                          decoration: BoxDecoration(
                            //background color of dropdown button
                            border: Border.all(
                                color: Colors.black38,
                                width: 1), //border of dropdown button
                            borderRadius: BorderRadius.circular(
                                30), //border raiuds of dropdown button
                          ),
                          child: DropdownButton(
                            value: promotion,
                            onChanged: (String? newValue) {
                              setState(() {
                                promotion = newValue!;
                              });
                            },
                            // ignore: prefer_const_literals_to_create_immutables

                            items: <String>[
                              'ไม่มีโปรโมชั่น',
                              'โปรโมชั่น 10%',
                              'โปรโมชั่น 20%',
                              'โปรโมชั่น 30%',
                              'โปรโมชั่น 50%',
                              'โปรโมชั่น ซื้อ 1 แถม 1'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width: 200, // for example
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(value),
                                  ),
                                ),
                              );
                            }).toList(),
                            icon: Padding(
                                //Icon at tail, arrow bottom is default icon
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.arrow_downward)),
                            iconEnabledColor:
                                Color.fromARGB(255, 0, 0, 0), //Icon color

                            //dropdown background color
                            underline: Container(), //remove underline
                            isExpanded: true, //make true to make width 100%
                          ),
                        )
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
