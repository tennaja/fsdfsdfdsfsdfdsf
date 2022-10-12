import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/model/product_model.dart';
import 'package:project_bekery/model/product_promotion.dart';
import 'package:project_bekery/model/promotion_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';

class admin_addproductpromotion extends StatefulWidget {
  const admin_addproductpromotion({Key? key}) : super(key: key);

  @override
  State<admin_addproductpromotion> createState() =>
      _admin_addproductpromotionState();
}

class _admin_addproductpromotionState extends State<admin_addproductpromotion> {
  List<Product_promotion>? _product_promotion;
  int? datalength;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<String> productnamelist = [];
  List<Product>? productlist;
  List<String> promotionnamelist = [];
  List<Promotion>? promotionlist;
  String promotion = 'ไม่มีโปรโมชั่น';
  String? product, product_id, promotion_id;

  String? current_promotionid,
      current_promotionname,
      current_promotionvalue,
      status;
  @override
  void initState() {
    super.initState();
    _product_promotion = [];
    _getpromotion();
    status = 'เพิ่มข้อมูล';
  }

  Future<void> _selectstartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectendDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  _getpromotionlist() {
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
  }

  _getpromotion() {
    print("function working");
    Art_Services().getall_product_promotion().then((promotion) {
      setState(() {
        _product_promotion = promotion;
        datalength = promotion.length;
      });

      print('จำนวข้อมูล : ${promotion.length}');
    });
    Art_Services().getall_promotion().then((value) {
      print('ตัวอย่างข้อมูล : ${value[0].promotion_name}');
      for (var i = 0; i < value.length; i++) {
        setState(() {
          promotionnamelist.insert(i, '${value[i].promotion_name}');
        });
      }
    });

    Art_Services().getProduct('SELECT * FROM product WHERE 1').then((value) {
      print('ตัวอย่างข้อมูล : ${value[0].product_name}');
      for (var i = 0; i < value.length; i++) {
        setState(() {
          productnamelist.insert(i, '${value[i].product_name}');
        });
      }
      setState(() {
        product = value[0].product_name;
      });
    });
  }

  _addproduct_promotion() {
    Art_Services()
        .getProduct("SELECT * FROM product WHERE product_name = '${product}'")
        .then((value) {
      setState(() {
        product_id = value[0].product_id;
      });
    }).then((value) {
      Art_Services().getonly_promotionbyname(promotion).then((value) {
        setState(() {
          promotion_id = value[0].promotion_id;
        });
      }).then((value) {
        _checkproduct_promotion(product_id, promotion_id);
      });
    });
  }

  _checkproduct_promotion(productid, promotionid) {
    Art_Services()
        .getonly_product_promotion(productid, promotionid)
        .then((value) {
      if (value.isEmpty) {
        print('ไม่มีข้อมูลซ้ำ');
        print('productid : ${productid}');
        print('promotionid : ${promotionid}');
        print('startDate : ${startDate}');
        print('endDate : ${endDate}');
        Art_Services()
            .add_product_promotion(productid.toString(), promotionid.toString(),
                startDate.toString(), endDate.toString())
            .then((value) {
          Fluttertoast.showToast(
              msg: "เพิ่มข้อมูลเสร็จสิ้น",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 13, 255, 0),
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return admin_addproductpromotion();
          }));
        });
      } else {
        print('มีข้อมูลซ้ำ');
      }
    });
  }

  _updateproducttype(producttype_name) {
    Art_Services().getonly_producttype(producttype_name).toString();
  }

  @override
  Widget build(BuildContext context) {
    final fromKey = GlobalKey<FormState>();
    String? promotion_name, promotion_value;
    return Scaffold(
      backgroundColor: Colorz.complexDrawerBlack,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF5e548e),
        title: Text('เพิ่มโปรโมชั่นให้สินค้า'),
      ),
      drawer: ComplexDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: status == 'เพิ่มข้อมูล'
                    ? Form(
                        key: fromKey,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            DecoratedBox(
                                decoration: BoxDecoration(
                                  //background color of dropdown button
                                  border: Border.all(
                                      color: Colors
                                          .white), //border of dropdown button
                                  borderRadius: BorderRadius.circular(
                                      30), //border raiuds of dropdown button
                                ),
                                child: DropdownButton(
                                  dropdownColor: Colorz.complexDrawerBlack,
                                  value: product,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      product = newValue!;
                                    });
                                  },
                                  // ignore: prefer_const_literals_to_create_immutables

                                  items: productnamelist
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(
                                        width: 200, // for example
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  icon: Padding(
                                      //Icon at tail, arrow bottom is default icon
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_downward)),
                                  iconEnabledColor: Color.fromARGB(
                                      255, 255, 255, 255), //Icon color

                                  //dropdown background color
                                  underline: Container(), //remove underline
                                  isExpanded:
                                      true, //make true to make width 100%
                                )),
                            SizedBox(height: 20),
                            DecoratedBox(
                                decoration: BoxDecoration(
                                  //background color of dropdown button
                                  border: Border.all(
                                      color: Colors
                                          .white), //border of dropdown button
                                  borderRadius: BorderRadius.circular(
                                      30), //border raiuds of dropdown button
                                ),
                                child: DropdownButton(
                                  dropdownColor: Colorz.complexDrawerBlack,
                                  value: promotion,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      promotion = newValue!;
                                    });
                                  },
                                  // ignore: prefer_const_literals_to_create_immutables

                                  items: promotionnamelist
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(
                                        width: 200, // for example
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  icon: Padding(
                                      //Icon at tail, arrow bottom is default icon
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_downward)),
                                  iconEnabledColor: Color.fromARGB(
                                      255, 255, 255, 255), //Icon color

                                  //dropdown background color
                                  underline: Container(), //remove underline
                                  isExpanded:
                                      true, //make true to make width 100%
                                )),
                            SizedBox(height: 20),
                            TextFormField(
                              initialValue:
                                  DateFormat('วันที่ d เดือน MMMM ปี y', 'th')
                                      .format(startDate)
                                      .toString(),
                              style: TextStyle(color: Colors.white),
                              onTap: () {
                                _selectstartDate(context);
                              },
                              readOnly: true,
                              keyboardType: TextInputType.number,
                              validator: RequiredValidator(
                                  errorText: "กรุณาป้อนข้อมูล"),
                              autofocus: false,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                suffixIcon: new IconButton(
                                  onPressed: () {
                                    _selectstartDate(context);
                                  },
                                  icon: Icon(
                                    Icons.edit_calendar,
                                    color: Colors.white,
                                  ),
                                ),
                                label: Text(
                                  'วันที่เริ่มโปรโมชั่น',
                                  style: TextStyle(color: Colors.white),
                                ),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              readOnly: true,
                              initialValue: DateFormat(
                                'วันที่ d เดือน MMMM ปี y',
                                'th',
                              ).format(endDate).toString(),
                              style: TextStyle(color: Colors.white),
                              onTap: () {
                                _selectendDate(context);
                              },
                              keyboardType: TextInputType.number,
                              validator: RequiredValidator(
                                  errorText: "กรุณาป้อนข้อมูล"),
                              autofocus: false,
                              decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                suffixIcon: new Icon(
                                  Icons.edit_calendar,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'วันที่หมดอายุโปโมชั่น',
                                  style: TextStyle(color: Colors.white),
                                ),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                //background color of dropdown button
                                border: Border.all(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 1), //border of dropdown button
                                borderRadius: BorderRadius.circular(
                                    30), //border raiuds of dropdown button
                              ),
                              child: SizedBox(
                                width: 350,
                                height: 40,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF5e548e),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                      //////// HERE
                                    ),
                                    child: Text(
                                      'เพิ่มโปรโมชั่นให้สินค้า',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      if (fromKey.currentState!.validate()) {
                                        fromKey.currentState!.save();
                                        if (endDate.isBefore(startDate)) {
                                          print('end before start');
                                        } else {
                                          _addproduct_promotion();
                                        }
                                      }
                                    }),
                              ),
                            ),
                          ],
                        ))
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),

              //ตาราง

              Expanded(
                  child: _product_promotion?.length != 0
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: DataTable(
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          'ชื่อสินค้า',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      DataColumn(
                                          label: Text(
                                        'ชื่อโปรโมชั่น',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'ส่วนลด',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'วันที่เริ่ม',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'วันที่สิ้นสุด',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'ลบ',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'สถานะ',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ],
                                    rows: _product_promotion!
                                        .map(
                                          (Promotion) => DataRow(cells: [
                                            DataCell(Text(
                                              Promotion.product_name.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            DataCell(Text(
                                              Promotion.promotion_name
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            DataCell(Text(
                                              Promotion.promotion_value
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            DataCell(Text(
                                              Promotion.start_date.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            DataCell(Text(
                                              Promotion.end_date.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            DataCell(IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                showDialog<bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          'ลบข้อมูล',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0)),
                                                        ),
                                                        content: const Text(
                                                          'ต้องการที่จะลบประเภทสินค้านี้ใช้ไหม?',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0)),
                                                        ),
                                                        actions: <Widget>[
                                                          ElevatedButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                            child: const Text(
                                                              "ไม่",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Art_Services()
                                                                  .deleteproduct_promotion(
                                                                      Promotion
                                                                          .product_id
                                                                          .toString(),
                                                                      Promotion
                                                                          .promotion_id
                                                                          .toString())
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            Fluttertoast.showToast(
                                                                                msg: "ลบ ${Promotion.promotion_name.toString()} เรียบร้อย",
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                gravity: ToastGravity.BOTTOM,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Color.fromARGB(255, 255, 0, 0),
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0),
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (context) {
                                                                              return admin_addproductpromotion();
                                                                            }))
                                                                          });
                                                            },
                                                            child: const Text(
                                                              "ใช่",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            )),
                                            DataCell(textstatus(
                                                Promotion.product_id,
                                                Promotion.promotion_id)),
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
        ),
      ),
    );
  }
}

class textstatus extends StatefulWidget {
  String? product_id, promotion_id;
  textstatus(this.product_id, this.promotion_id, {Key? key}) : super(key: key);

  @override
  State<textstatus> createState() => _textstatusState();
}

class _textstatusState extends State<textstatus> {
  String? promotionname;
  List<Product_promotion>? _product_promotion;
  int datalenght = 0;

  _getpromotion() {
    print("function working");
    print(
      widget.product_id,
    );
    print(
      widget.promotion_id,
    );
    print(DateFormat('yyyy-MM-d').format(DateTime.now()).toString());
    Art_Services()
        .getonly_product_promotion_status(
            widget.product_id,
            widget.promotion_id,
            DateFormat('yyyy-MM-d').format(DateTime.now()).toString())
        .then((promotion) {
      setState(() {
        _product_promotion = promotion;
        promotionname = _product_promotion![0].promotion_value.toString();
        datalenght = promotion.length;
      });
    });
  }

  void initState() {
    super.initState();
    _getpromotion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: datalenght == 0
          ? Container(
              child: Text(
                'ไม่พร้อมใช้งาน',
                style: TextStyle(color: Colors.red),
              ),
            )
          : Container(
              child: Text(
                'พร้อมใช้งาน',
                style: TextStyle(color: Colors.green),
              ),
            ),
    );
  }
}
