// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bekery/screen/productdetail.dart';
import 'package:project_bekery/screen/user_order.dart';
import 'package:project_bekery/screen/user_welcome.dart';

import '../widgets/big_text.dart';
import '../widgets/colors.dart';

class product_quantity extends StatefulWidget {
  final String doc;
  const product_quantity(this.doc, {Key? key}) : super(key: key);

  @override
  _product_quantityState createState() => _product_quantityState();
}

class _product_quantityState extends State<product_quantity> {
  int quantity = 1;
  final auth = FirebaseAuth.instance;

  Future<void> add_order(quantity) async {
    FirebaseFirestore.instance
        .collection('product')
        .doc(widget.doc)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data1 =
          documentSnapshot.data() as Map<String, dynamic>;
      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.email)
          .update({
        'user_cart': FieldValue.arrayUnion([
          {
            "product_id": data1['product_id'],
            "product_name": data1['product_name'],
            "product_quantity": quantity,
            "product_price": data1['product_price'].toString(),
            "total_price": data1['product_price'] * quantity
          }
        ])
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.email)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          Map<String, dynamic> data2 =
              documentSnapshot.data() as Map<String, dynamic>;
          for (var i = 0; i < data2["user_cart"]?.length; i++) {
            FirebaseFirestore.instance
                .collection('product')
                .doc(widget.doc)
                .update({
              "product_quantity": FieldValue.increment(
                  -data2['user_cart'][i]['product_quantity']),
              "export_product": FieldValue.increment(
                  data2['user_cart'][i]['product_quantity']),
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CollectionReference users =
        FirebaseFirestore.instance.collection('product');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.doc).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          int quantity_val = 1;
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(
                        child: Icon(
                      Icons.remove,
                      size: 20,
                    )),
                  ),
                  onTap: () {
                    setState(() {
                      quantity--;
                    });
                  }),
              SizedBox(
                width: height / 84.4 / 2,
              ),
              Bigtext(
                text: quantity.toString(),
                color: Colors.black,
              ),
              SizedBox(
                width: height / 84.4 / 2,
              ),
              InkWell(
                  child: const SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(child: Icon(Icons.add, size: 20)),
                  ),
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  }),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  try {
                    add_order(quantity).then((value) {
                      Fluttertoast.showToast(
                          msg: "ซื้อของเรียบร้อย",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Orderpage();
                      }));
                    });
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: "ของชิ้นนี้ถูกซื้อไปแล้ว",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Container(
                    padding: EdgeInsets.only(
                        top: height / 42.2,
                        bottom: height / 42.2,
                        left: height / 42.2,
                        right: height / 42.2),
                    child: Bigtext(
                      text: "200 บาท | เพิ่มลงตระกร้า ",
                      color: Colors.white,
                      size: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height / 42.2),
                      color: AppColors.MainColor,
                    )),
              ),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                      child: Icon(
                    Icons.remove,
                    size: 20,
                  )),
                ),
                onTap: () {
                  setState(() {
                    quantity--;
                  });
                }),
            SizedBox(
              width: height / 84.4 / 2,
            ),
            Bigtext(
              text: quantity.toString(),
              color: Colors.black,
            ),
            SizedBox(
              width: height / 84.4 / 2,
            ),
            InkWell(
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(child: Icon(Icons.add, size: 20)),
                ),
                onTap: () {
                  setState(() {
                    quantity++;
                  });
                }),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                try {
                  add_order(quantity).then((value) {
                    Fluttertoast.showToast(
                        msg: "ซื้อของเรียบร้อย",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Orderpage();
                    }));
                  });
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: "ของชิ้นนี้ถูกซื้อไปแล้ว",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Container(
                  padding: EdgeInsets.only(
                      top: height / 42.2,
                      bottom: height / 42.2,
                      left: height / 42.2,
                      right: height / 42.2),
                  child: Bigtext(
                    text: "200 บาท | เพิ่มลงตระกร้า ",
                    color: Colors.white,
                    size: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height / 42.2),
                    color: AppColors.MainColor,
                  )),
            ),
          ],
        );
      },
    );
  }
}
