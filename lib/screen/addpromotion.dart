import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/model/promotion_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';

class addpromotion extends StatefulWidget {
  const addpromotion({Key? key}) : super(key: key);

  @override
  State<addpromotion> createState() => _addpromotionState();
}

class _addpromotionState extends State<addpromotion> {
  List<Promotion>? _promotion;
  int? datalength;
  String? current_promotionid,
      current_promotionname,
      current_promotionvalue,
      status;
  @override
  void initState() {
    super.initState();
    _promotion = [];
    _getpromotion();
    status = 'เพิ่มข้อมูล';
  }

  _getpromotion() {
    print("function working");
    Art_Services().getall_promotion().then((producttype) {
      setState(() {
        _promotion = producttype;
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
    final fromKey = GlobalKey<FormState>();
    String? promotion_name, promotion_value;
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.white,
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  status = 'เพิ่มข้อมูล';
                });
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )),
          appBarHeight: 85,
          appBarColor: Color(0xFF5e548e),
          title: Container(
            child: Center(
                child: const Text(
              'เพิ่มโปรโมชั่น',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        slider: ComplexDrawer(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colorz.complexDrawerBlack,
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
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                onSaved: (name) {
                                  setState(() {
                                    promotion_name = name;
                                  });
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
                                    'ชื่อโปรโมชั่น',
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
                              SizedBox(height: 20),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.number,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                onSaved: (value) {
                                  setState(() {
                                    promotion_value = value;
                                  });
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
                                    'ปริมาการลด %',
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
                                        primary: Color(0xFF5e548e),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        //////// HERE
                                      ),
                                      child: Text('เพิ่มโปรโมชั่น'),
                                      onPressed: () async {
                                        print(promotion_name);
                                        print(promotion_value);
                                        if (fromKey.currentState!.validate()) {
                                          fromKey.currentState!.save();
                                          Utils(context).startLoading();
                                          Art_Services()
                                              .getonly_promotion(
                                                  promotion_name.toString(),
                                                  promotion_value)
                                              .then((value) => {
                                                    print(
                                                        'จำนวนขอมูลPromotion : ${value.length}'),
                                                    if (value.length > 0)
                                                      {
                                                        Utils(context)
                                                            .stopLoading(),
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "มีโปรโมชั่นดังกล่าวแล้ว",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    0,
                                                                    0),
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0),
                                                      }
                                                    else
                                                      {
                                                        Art_Services()
                                                            .add_promotion(
                                                                promotion_name
                                                                    .toString(),
                                                                promotion_value
                                                                    .toString())
                                                            .then((value) => {
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "เพิ่มโปรโมชั่นเรียบร้อย",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          1,
                                                                      backgroundColor:
                                                                          Color.fromARGB(
                                                                              255,
                                                                              60,
                                                                              255,
                                                                              0),
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          16.0),
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return addpromotion();
                                                                  })),
                                                                })
                                                      }
                                                  });
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ))
                      : Container(
                          child: Form(
                              key: fromKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: current_promotionname,
                                    style: TextStyle(color: Colors.white),
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    onSaved: (name) {
                                      setState(() {
                                        promotion_name = name;
                                      });
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
                                      label: Text(
                                        'ชื่อโปรโมชั่น',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: current_promotionvalue,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    onSaved: (value) {
                                      setState(() {
                                        promotion_value = value;
                                      });
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
                                      label: Text(
                                        'ปริมาการลด %',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
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
                                          child: Text('แก้ไขโปรโมชั่น'),
                                          onPressed: () async {
                                            print(promotion_name);
                                            print(promotion_value);
                                            if (fromKey.currentState!
                                                .validate()) {
                                              fromKey.currentState!.save();
                                              Art_Services()
                                                  .getonly_promotion(
                                                      promotion_name.toString(),
                                                      promotion_value)
                                                  .then((value) => {
                                                        print(
                                                            'จำนวนขอมูลPromotion : ${value.length}'),
                                                        if (value.length > 0)
                                                          {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "มีโปรโมชั่นดังกล่าวแล้ว",
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
                                                                .editpromotion(
                                                                    current_promotionid,
                                                                    promotion_name
                                                                        .toString(),
                                                                    promotion_value
                                                                        .toString())
                                                                .then(
                                                                    (value) => {
                                                                          Fluttertoast.showToast(
                                                                              msg: "เพิ่มโปรโมชั่นเรียบร้อย",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              timeInSecForIosWeb: 1,
                                                                              backgroundColor: Color.fromARGB(255, 60, 255, 0),
                                                                              textColor: Colors.white,
                                                                              fontSize: 16.0),
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) {
                                                                            return addpromotion();
                                                                          })),
                                                                        })
                                                          }
                                                      });
                                            }
                                          }),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),

                //ตาราง

                Expanded(
                    child: _promotion?.length != 0
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
                                          'ชื่อโปรมโมชั่น',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'ส่วนลด %',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'ลบ',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'แก้ไข',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ],
                                      rows: _promotion!
                                          .map(
                                            (Promotion) => DataRow(cells: [
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
                                              DataCell(
                                                  Promotion.promotion_id == "0"
                                                      ? Container()
                                                      : IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            showDialog<bool>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'ลบข้อมูล'),
                                                                    content:
                                                                        const Text(
                                                                            'ต้องการที่จะลบประเภทสินค้านี้ใช้ไหม?'),
                                                                    actions: <
                                                                        Widget>[
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.of(context).pop(),
                                                                        child: const Text(
                                                                            "ไม่"),
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Art_Services().deletepromotion(Promotion.promotion_id.toString()).then((value) =>
                                                                              {
                                                                                Fluttertoast.showToast(msg: "ลบ ${Promotion.promotion_name.toString()} เรียบร้อย", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Color.fromARGB(255, 255, 0, 0), textColor: Colors.white, fontSize: 16.0),
                                                                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                  return addpromotion();
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
                                              DataCell(
                                                  Promotion.promotion_id == "0"
                                                      ? Container()
                                                      : IconButton(
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              current_promotionid =
                                                                  '${Promotion.promotion_id}';
                                                              current_promotionname =
                                                                  '${Promotion.promotion_name}';
                                                              current_promotionvalue =
                                                                  '${Promotion.promotion_value}';
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
          ),
        ),
      ),
    );
  }
}
