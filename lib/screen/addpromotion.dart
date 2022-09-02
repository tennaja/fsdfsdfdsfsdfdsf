import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';

class addpromotion extends StatefulWidget {
  const addpromotion({Key? key}) : super(key: key);

  @override
  State<addpromotion> createState() => _addpromotionState();
}

class _addpromotionState extends State<addpromotion> {
  @override
  Widget build(BuildContext context) {
    final fromKey = GlobalKey<FormState>();
    String? promotion_name, promotion_value;
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
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
          child: Form(
            key: fromKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    validator: RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
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
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
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
                        borderSide: const BorderSide(color: Colors.black),
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
                                borderRadius: BorderRadius.circular(32.0)),
                            //////// HERE
                          ),
                          child: Text('เพิ่มโปรโมชั่น'),
                          onPressed: () async {
                            print(promotion_name);
                            print(promotion_value);
                            if (fromKey.currentState!.validate()) {
                              fromKey.currentState!.save();
                              Art_Services()
                                  .getonly_promotion(promotion_name.toString())
                                  .then((value) => {
                                        print(
                                            'จำนวนขอมูลPromotion : ${value.length}'),
                                        if (value.length > 0)
                                          {
                                            Fluttertoast.showToast(
                                                msg: "มีโปรโมชั่นดังกล่าวแล้ว",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Color.fromARGB(
                                                    255, 255, 0, 0),
                                                textColor: Colors.white,
                                                fontSize: 16.0),
                                          }
                                        else
                                          {
                                            Art_Services()
                                                .add_promotion(
                                                    promotion_name.toString(),
                                                    promotion_value.toString())
                                                .then((value) => {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "เพิ่มโปรโมชั่นเรียบร้อย",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  60,
                                                                  255,
                                                                  0),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0),
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return admin_import_order();
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
          ),
        ),
      ),
    );
  }
}
