import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/model/promotion_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';

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
              'รายการนำเข้าสินค้า',
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
          height: double.infinity,
          color: Colors.orangeAccent.withOpacity(0.5),
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
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                onSaved: (name) {
                                  setState(() {
                                    promotion_name = name;
                                  });
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  label: Text('ชื่อโปรโมชั่น'),
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
                                  label: Text('ปริมาการลด %'),
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
                                        primary: Colors.orangeAccent,
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
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    onSaved: (name) {
                                      setState(() {
                                        promotion_name = name;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      label: Text('ชื่อโปรโมชั่น'),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: current_promotionvalue,
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
                                      label: Text('ปริมาการลด %'),
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
                    color: Colors.black,
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
                                            label: Text('ชื่อโปรมโมชั่น')),
                                        DataColumn(label: Text('ส่วนลด %')),
                                        DataColumn(label: Text('ลบ')),
                                        DataColumn(label: Text('แก้ไข')),
                                      ],
                                      rows: _promotion!
                                          .map(
                                            (Promotion) => DataRow(cells: [
                                              DataCell(Text(Promotion
                                                  .promotion_name
                                                  .toString())),
                                              DataCell(Text(Promotion
                                                  .promotion_value
                                                  .toString())),
                                              DataCell(
                                                  Promotion.promotion_id == "0"
                                                      ? Container()
                                                      : IconButton(
                                                          icon: Icon(
                                                              Icons.delete),
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
                                                          icon:
                                                              Icon(Icons.edit),
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
