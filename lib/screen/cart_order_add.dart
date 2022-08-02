import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bekery/screen/user_welcome.dart';
import 'package:uuid/uuid.dart';
import 'package:project_bekery/mysql/service.dart';

class cart_order_add extends StatefulWidget {
  const cart_order_add({Key? key}) : super(key: key);

  @override
  _cart_order_addState createState() => _cart_order_addState();
}

_add_order(order_id, order_by, user_latitude, user_longitude,
    order_responsible_person, total_price, order_status) {
  Services().add_order(
      order_id.toString(),
      order_by.toString(),
      user_latitude.toString(),
      user_longitude.toString(),
      order_responsible_person.toString(),
      total_price.toString(),
      order_status.toString());
  print('!!funtion ativate!!');
}

_addOrderdtail(order_id, product_id, product_amount, product_per_price, total) {
  print(order_id);
  print(product_id);
  print(product_amount);
  print(product_per_price);
  print(total);
  Services().addOrderdtail(order_id.toString(), product_id.toString(),
      product_amount.toString(), product_per_price, total.toString());
  print('!!funtion ativate!!');
}

class _cart_order_addState extends State<cart_order_add> {
  final auth = FirebaseAuth.instance;
  Future<void> createorder(data, l) async {
    var uuid = Uuid().v1().toString();
    int total = 0;
    int total1 = 0;
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data1 =
            documentSnapshot.data() as Map<String, dynamic>;

        for (int i = 0; i < l; i++) {
          _addOrderdtail(
              uuid,
              data1['user_cart'][i]['product_id'],
              data1['user_cart'][i]['product_quantity'],
              data1['user_cart'][i]['product_price'],
              data1['user_cart'][i]['total_price']);
          FirebaseFirestore.instance
              .collection('users')
              .doc(auth.currentUser!.email)
              .update({
            'user_cart': FieldValue.arrayRemove([
              {
                'product_id': data1['user_cart'][i]['product_id'],
                'product_name': data1['user_cart'][i]['product_name'],
                'product_price': data1['user_cart'][i]['product_price'],
                'product_quantity': data1['user_cart'][i]['product_quantity'],
                'total_price': data1['user_cart'][i]['total_price']
              }
            ]),
          });

          total = data1['user_cart'][i.toInt()]['total_price'];
          total1 += total;

          print('-------------------------------------');
          print(data1['user_cart'][i.toInt()]['total_price']);
          print('Sum is : ${total1}');
        }
        CollectionReference users =
            FirebaseFirestore.instance.collection('order');
        FirebaseFirestore.instance
            .collection('order')
            .get()
            .then((QuerySnapshot querySnapshot) {
          _add_order(uuid, auth.currentUser!.email, data1['u_latitude'],
              data1['u_longitude'], 'ยังไม่มีผู้รับ', total1, 'ยังไม่ได้ขาย');
          users.doc(uuid).set({
            'order_by': auth.currentUser!.email,
            'order_id': uuid,
            'latitude': data1['u_latitude'],
            'longitude': data1['u_longitude'],
            'order_detail': data,
            'total_price': total1,
            'order_date': DateTime.now(),
            'order_status': 'ยังไม่ได้ขาย',
            'order_responsible_person': 'ยังไม่มีผู้รับ',
          }).then((value) {
            setState(() {
              total = 0;
              total1 = 0;
            });
          });
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser!.email).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text('Admin_cart');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data["user_cart"]?.length < 1) {
            return Scaffold(
              extendBodyBehindAppBar: true,
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
                backgroundColor: Colors.white.withOpacity(0.1),
                elevation: 0,
                title: Center(
                    child: const Text(
                  'ตระกร้าสินค้า',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
              ),
              body: Container(
                color: Colors.orangeAccent.withOpacity(0.5),
              ),
            );
          }
          return Scaffold(
              extendBodyBehindAppBar: true,
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
                title: Center(
                  child: const Text(
                    'ตระกร้าสินค้า',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(0.1),
                elevation: 0,
              ),
              body: Container(
                color: Colors.orangeAccent.withOpacity(0.5),
                child: Column(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                          data != null ? (data["user_cart"]?.length ?? 0) : 0,
                      itemBuilder: (_, index) => Card(
                        margin: EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(data['user_cart'][index]['product_name']
                              .toString()),
                          subtitle: Text(data['user_cart'][index]['total_price']
                              .toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    print(
                                        data['user_cart'][index]['product_id']);
                                    print(data['user_cart'][index]
                                        ['product_price']);
                                    FirebaseFirestore.instance
                                        .collection('product')
                                        .doc(data['user_cart'][index]
                                            ['product_id'])
                                        .update({
                                      'product_quantity': FieldValue.increment(
                                          data['user_cart'][index]
                                              ['product_quantity']),
                                      'export_product': FieldValue.increment(
                                        -data['user_cart'][index]
                                            ['product_quantity'],
                                      ),
                                    }).then((value) {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(auth.currentUser!.email)
                                          .update({
                                        'user_cart': FieldValue.arrayRemove([
                                          {
                                            'product_id': data['user_cart']
                                                [index]['product_id'],
                                            'product_name': data['user_cart']
                                                [index]['product_name'],
                                            'product_price': data['user_cart']
                                                [index]['product_price'],
                                            'product_quantity':
                                                data['user_cart'][index]
                                                    ['product_quantity'],
                                            'total_price': data['user_cart']
                                                [index]['total_price']
                                          }
                                        ]),
                                      });
                                    }).then((value) {
                                      setState(() {});
                                      Fluttertoast.showToast(
                                          msg:
                                              "ลบเรียบร้อย ${data['user_cart'][index]['product_id']}",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color.fromARGB(255, 255, 1, 1),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          child: Text('อัปโหลดข้อมูล'),
                          onPressed: () {
                            createorder(
                                    data['user_cart'], data['user_cart'].length)
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg: "ซื้อสินค้าเสร็จสิน",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 251, 0),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            });
                          }),
                    ),
                  ],
                ),
              ));
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Loading'),
          ),
        );
      },
    );
  }
}
