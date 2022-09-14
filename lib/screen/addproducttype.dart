import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/model/producttype.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';

class addproducttype extends StatefulWidget {
  const addproducttype({Key? key}) : super(key: key);

  @override
  State<addproducttype> createState() => _addproducttypeState();
}

class _addproducttypeState extends State<addproducttype> {
  List<Producttype>? _producttype;
  int? datalength;
  String? status, current_producttypename, current_producttypeid;

  @override
  void initState() {
    super.initState();
    _producttype = [];
    _getproducttype();
    status = 'เพิ่มข้อมูล';
  }

  _getproducttype() {
    print("function working");
    Art_Services().getall_producttype().then((producttype) {
      setState(() {
        _producttype = producttype;
        datalength = producttype.length;
      });

      print('จำนวข้อมูล : ${producttype.length}');
    });
  }

  _updateproducttype(producttype_name) {
    Art_Services().getonly_producttype(producttype_name).toString();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final fromKey = GlobalKey<FormState>();
    String? producttype_name;
    return Scaffold(
      body: SliderDrawer(
          appBar: SliderAppBar(
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    status = 'เพิ่มข้อมูล';
                  });
                },
                icon: Icon(Icons.add)),
            appBarHeight: 85,
            appBarColor: Color.fromARGB(255, 255, 222, 178),
            title: Container(
              child: Center(
                  child: const Text(
                'เพิ่มประเภทสินค้า',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          slider: AdminAppBar(),
          child: Container(
            width: double.infinity,
            color: Colors.orangeAccent.withOpacity(0.5),
            child: Column(
              children: [
                Container(
                    child: status == 'เพิ่มข้อมูล'
                        ? Form(
                            key: fromKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  TextFormField(
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    onSaved: (name) {
                                      setState(() {
                                        producttype_name = name;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      label: Text('ชื่อประเภทสินค้า'),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
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
                                      width: 350,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orangeAccent,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                            //////// HERE
                                          ),
                                          child: Text('เพิ่มประเภทสินค้า'),
                                          onPressed: () async {
                                            print(producttype_name);
                                            if (fromKey.currentState!
                                                .validate()) {
                                              fromKey.currentState!.save();
                                              _updateproducttype(
                                                      producttype_name)
                                                  .then((value) => {
                                                        print(
                                                            'จำนวนขอมูลProducttype : ${value.length}'),
                                                        if (value.length > 0)
                                                          {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "มีประเภทสินค้าดังกล่าวแล้ว",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0),
                                                          }
                                                        else
                                                          {
                                                            Art_Services()
                                                                .add_producttype(
                                                                    producttype_name
                                                                        .toString())
                                                                .then(
                                                                    (value) => {
                                                                          Fluttertoast.showToast(
                                                                              msg: "เพิ่มประเภทสินค้าเรียบร้อย",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              timeInSecForIosWeb: 1,
                                                                              backgroundColor: Color.fromARGB(255, 60, 255, 0),
                                                                              textColor: Colors.white,
                                                                              fontSize: 16.0),
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) {
                                                                            return addproducttype();
                                                                          })),
                                                                        })
                                                          }
                                                      });
                                            }
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Form(
                            key: fromKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: current_producttypename,
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    onSaved: (name) {
                                      setState(() {
                                        producttype_name = name;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      label: Text('ชื่อประเภทสินค้า'),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
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
                                      width: 350,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orangeAccent,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                            //////// HERE
                                          ),
                                          child: Text('แก้ไขข้อมูล'),
                                          onPressed: () async {
                                            print(
                                                'ID producttype : ${current_producttypeid}');
                                            print(
                                                'ID producttype : ${producttype_name}');

                                            if (fromKey.currentState!
                                                .validate()) {
                                              fromKey.currentState!.save();
                                              Art_Services()
                                                  .getonly_producttype(
                                                      producttype_name
                                                          .toString())
                                                  .then((value) => {
                                                        print(
                                                            'จำนวนขอมูลProducttype : ${value.length}'),
                                                        if (value.length > 0)
                                                          {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "มีประเภทสินค้าดังกล่าวแล้ว",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0),
                                                          }
                                                        else
                                                          {
                                                            Art_Services()
                                                                .editproducttype(
                                                                    current_producttypeid,
                                                                    producttype_name
                                                                        .toString())
                                                                .then(
                                                                    (value) => {
                                                                          Fluttertoast.showToast(
                                                                              msg: "แก้ไขข้อมูลเรียบร้อย",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              timeInSecForIosWeb: 1,
                                                                              backgroundColor: Color.fromARGB(255, 60, 255, 0),
                                                                              textColor: Colors.white,
                                                                              fontSize: 16.0),
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) {
                                                                            return addproducttype();
                                                                          })),
                                                                        })
                                                          }
                                                      });
                                            }
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    child: _producttype?.length != 0
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: DataTable(
                                      columns: [
                                        DataColumn(label: Text('ID')),
                                        DataColumn(label: Text('ชื่อสินค้า')),
                                        DataColumn(label: Text('ลบ')),
                                        DataColumn(label: Text('แก้ไข')),
                                      ],
                                      rows: _producttype!
                                          .map(
                                            (importorder) => DataRow(cells: [
                                              DataCell(Text(importorder
                                                  .product_type_id
                                                  .toString())),
                                              DataCell(Text(importorder
                                                  .product_type_name
                                                  .toString())),
                                              DataCell(importorder
                                                          .product_type_id ==
                                                      "0"
                                                  ? Container()
                                                  : IconButton(
                                                      icon: Icon(Icons.delete),
                                                      onPressed: () {
                                                        showDialog<bool>(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'ลบข้อมูล'),
                                                                content: const Text(
                                                                    'ต้องการที่จะลบประเภทสินค้านี้ใช้ไหม?'),
                                                                actions: <
                                                                    Widget>[
                                                                  ElevatedButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(context)
                                                                            .pop(),
                                                                    child: const Text(
                                                                        "ไม่"),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Art_Services()
                                                                          .deleteproducttype(importorder
                                                                              .product_type_id
                                                                              .toString())
                                                                          .then((value) =>
                                                                              {
                                                                                Fluttertoast.showToast(msg: "ลบ ${importorder.product_type_name.toString()} เรียบร้อย", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Color.fromARGB(255, 255, 0, 0), textColor: Colors.white, fontSize: 16.0),
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                  return addproducttype();
                                                                                }))
                                                                              });
                                                                    },
                                                                    child: const Text(
                                                                        "ใช่"),
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                    )),
                                              DataCell(importorder
                                                          .product_type_id ==
                                                      "0"
                                                  ? Container()
                                                  : IconButton(
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () {
                                                        setState(() {
                                                          current_producttypeid =
                                                              '${importorder.product_type_id}';
                                                          current_producttypename =
                                                              '${importorder.product_type_name}';
                                                          status =
                                                              'แก้ไขข้อมูล';
                                                        });
                                                      },
                                                    )),
                                            ]),
                                          )
                                          .toList()),
                                ),
                              ),
                            ),
                          )
                        : Container()),
              ],
            ),
          )),
    );
  }
}
