import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';

class addproducttype extends StatefulWidget {
  const addproducttype({Key? key}) : super(key: key);

  @override
  State<addproducttype> createState() => _addproducttypeState();
}

class _addproducttypeState extends State<addproducttype> {
  @override
  Widget build(BuildContext context) {
    final fromKey = GlobalKey<FormState>();
    String? producttype_name;
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
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
                        producttype_name = name;
                      });
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                      label: Text('ชื่อประเภทสินค้า'),
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
                          child: Text('เพิ่มประเภทสินค้า'),
                          onPressed: () async {
                            print(producttype_name);
                            if (fromKey.currentState!.validate()) {
                              fromKey.currentState!.save();
                              Art_Services()
                                  .getonly_promotion(
                                      producttype_name.toString())
                                  .then((value) => {
                                        print(
                                            'จำนวนขอมูลPromotion : ${value.length}'),
                                        if (value.length > 0)
                                          {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "มีประเภทสินค้าดังกล่าวแล้ว",
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
                                                .add_producttype(
                                                    producttype_name.toString())
                                                .then((value) => {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "เพิ่มประเภทสินค้าเรียบร้อย",
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
