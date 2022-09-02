import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class admin_addpromotion extends StatefulWidget {
  const admin_addpromotion({Key? key}) : super(key: key);

  @override
  State<admin_addpromotion> createState() => _admin_addpromotionState();
}

class _admin_addpromotionState extends State<admin_addpromotion> {
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      onPressed: () {},
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
                            /*product_name = name.toString();*/
                          },
                          autofocus: false,
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
                            /*product_detail = detail.toString();*/
                          },
                          autofocus: false,
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
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                keyboardType: TextInputType.number,
                                onSaved: (price) {
                                  /*product_price = int.parse(price.toString());*/
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
                                  /*product_quantity =
                                      int.parse(quantity.toString());*/
                                },
                                autofocus: false,
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
