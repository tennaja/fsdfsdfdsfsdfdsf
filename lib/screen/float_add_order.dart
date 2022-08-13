// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors, must_be_immutable, camel_case_types, avoid_unnecessary_containers, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_bekery/script/firebaseapi.dart';
import 'package:project_bekery/model/product.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';

class add_product_order extends StatefulWidget {
  const add_product_order({Key? key}) : super(key: key);

  @override
  _add_product_orderState createState() => _add_product_orderState();
}

class _add_product_orderState extends State<add_product_order> {
  UploadTask? task;
  File? image;
  late String product_name;
  late String product_pice;
  late String product_img;
  String selecttype = '';
  String dropdownValue = 'ประเภทข้าวสาร';

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

  Future<void> uploadimage() async {
    int i = 0;
    CollectionReference users =
        FirebaseFirestore.instance.collection('product');
    if (image == null) return;
    final filename = basename(image!.path);
    final imagede = 'product_image/$filename';
    task = FirebaseApi.uploadfile(imagede, image!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download url : $urlDownload');

/*
    FirebaseFirestore.instance
        .collection('product')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        i++;
        print(i);
        print(doc["product_name"]);
      });
      var uuid = Uuid().toString();
      users.doc(uuid).set({
        "product_id": uuid,
        "product_image": urlDownload,
        "product_name": product_name,
        "product_price": product_pice,
        "product_type": dropdownValue

        /*
        "cart": FieldValue.arrayUnion([{
          "product_id": data['product_id'];
          "product_name": data['product_name'];
          "product_price":data[''];
        }])*/
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      primary: Colors.orangeAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(100, 40), //////// HERE
                    ),
                    child: Text('อัปโหลดรูปภาพ'),
                    onPressed: () {
                      pickImage_carmera();
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
                        onSaved: (name) {},
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
                        onSaved: (detail) {},
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
                              keyboardType: TextInputType.number,
                              onSaved: (price) {},
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
                              keyboardType: TextInputType.number,
                              onSaved: (price) {},
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
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          // ignore: prefer_const_literals_to_create_immutables

                          items: <String>[
                            'ประเภทข้าวสาร',
                            'ประเภทของใช้',
                            'ประเภทเครื่องปรุง'
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
                      /*
                      Text("ชื่อสิ้นค้า"),
                      TextFormField(
                        onChanged: (value) {
                          product_name = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("ราคาสิ้นค้า"),
                      TextFormField(
                        onChanged: (value) {
                          product_pice = value;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 15,
                      ),*/
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
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
                          primary: Colors.orangeAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(100, 40), //////// HERE
                        ),
                        child: Text('อัปโหลดข้อมูล'),
                        onPressed: () => uploadimage()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
