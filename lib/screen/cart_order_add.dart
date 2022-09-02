import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_bekery/model/user_basket.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/user_order.dart';
import 'package:project_bekery/screen/user_welcome.dart';
import 'package:uuid/uuid.dart';
import 'package:project_bekery/mysql/service.dart';

class cart_order_add extends StatefulWidget {
  final String email;
  const cart_order_add(this.email, {Key? key}) : super(key: key);

  @override
  _cart_order_addState createState() => _cart_order_addState();
}

class _cart_order_addState extends State<cart_order_add> {
  List<User>? _user;
  List<User_Basket>? userbasket;
  late int length;
  int totalprice = 0;
  @override
  void initState() {
    super.initState();
    userbasket = [];
    _getBasket();
    _getonlyuser();
  }

  _getBasket() {
    print("function working");
    Art_Services().getuserbasket(widget.email.toString()).then((basket) {
      setState(() {
        userbasket = basket;
        length = basket.length;
      });
      _gettotalprice(length);
      print("Length ${basket.length}");
    });
  }

  _getonlyuser() {
    print("function working");
    Art_Services().geyonlyuser(widget.email.toString()).then((user) {
      setState(() {
        _user = user;
      });
      print("Length ${user.length}");
      print(_user![0].user_latitude);
      print(_user![0].user_longitude);
    });
  }

  _getImportorder(length) {
    int Import_totalprice = 0;
    var Import_order_id = Uuid().v1();
    print('length data for loop === ${length}');
    print('-----------รายการที่จะส่ง-------------');
    print('---รหัสสินค้า [${Import_order_id}]---');
    for (int i = 0; i < length; i++) {
      print('รายการที่[${i}]');
      print(
          'รหัสรายการสิ้นค้า ----> [${userbasket![i].user_basket_product_id.toString()}]');
      print(
          'จำนวนสิ้นค้า ----> [${userbasket![i].user_basket_quantity.toString()}]');
      print(
          'ราคารวม ----> [${userbasket![i].user_basket_pricetotal.toString()}]');
      print('วันเวลาที่สั่ง ----> [${DateTime.now()}]');
      setState(() {
        Import_totalprice +=
            int.parse(userbasket![i].user_basket_pricetotal.toString());
      });
      Art_Services().addOrderdtail(
        Import_order_id.toString(),
        userbasket![i].user_basket_product_id.toString(),
        userbasket![i].user_basket_quantity.toString(),
        userbasket![i].product_price.toString(),
        userbasket![i].user_basket_pricetotal.toString(),
      );

      Art_Services().product_quantity_update(
          userbasket![i].user_basket_product_id.toString(),
          userbasket![i].user_basket_quantity.toString());
    }
    print("ราคารวมรายการ : ${Import_totalprice}");
    print(
        'userLocation : ${_user![0].user_latitude}  ,  ${_user![0].user_longitude}');
    Art_Services().add_order(
        Import_order_id.toString(),
        widget.email.toString(),
        _user![0].user_latitude.toString(),
        _user![0].user_longitude.toString(),
        'ยังไม่มีคนรับผิดชอบ'.toString(),
        Import_totalprice.toString(),
        'ยังไม่มีใครรับ',
        DateTime.now().toString());
    print('-----------จบการส่งข้อมูล-------------');
    setState(() {
      Import_totalprice = 0;
    });
    Art_Services().deleteuserbasket(widget.email).then((value) => {
          Fluttertoast.showToast(
              msg: "สั่งซื้อเสร็จสิ้น",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 4, 255, 0),
              textColor: Colors.white,
              fontSize: 16.0),
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Orderpage();
          })),
        });
  }

  _gettotalprice(length) {
    totalprice = 0;
    for (int i = 0; i < length; i++) {
      setState(() {
        totalprice +=
            int.parse(userbasket![i].user_basket_pricetotal.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 250,
            child: FloatingActionButton.extended(
              onPressed: () {
                if (_user![0].user_latitude == '0' ||
                    _user![0].user_longitude == '0') {
                  Fluttertoast.showToast(
                      msg: "กรุณายืนยันตำแหน่งของคุณก่อน",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Color.fromARGB(255, 255, 0, 0),
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 252, 187, 101),
                          title: const Text('ยืนยันการสั่งซื้อ'),
                          content: Text('ยืนยันการสั่งซื้อใช้ไหม?'),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orangeAccent),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                "ไม่",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orangeAccent),
                              ),
                              onPressed: () {
                                _getImportorder(length);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Orderpage();
                                }));
                              },
                              child: const Text("ใช่",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        );
                      });
                }
              },
              label: Text("ราคารวม : ${totalprice.toString()}"),
              icon: Icon(Icons.shopping_bag),
              backgroundColor: Color.fromARGB(255, 248, 146, 13),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Orderpage();
              }));
            },
          ),
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          title: Center(
              child: const Text(
            'รายการสินค้า',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () {
                _getBasket();
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                          userbasket != null ? (userbasket?.length ?? 0) : 0,
                      itemBuilder: (_, index) => Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                leading: Image(
                                  image: NetworkImage(userbasket![index]
                                      .product_image
                                      .toString()),
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(
                                    userbasket![index].product_name.toString()),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'จำนวน : ${userbasket![index].user_basket_quantity.toString()}'),
                                    Text(
                                        'ราคารวม : ${userbasket![index].user_basket_pricetotal.toString()}'),
                                  ],
                                ),
                                tileColor: Colors.orangeAccent,
                                trailing: IconButton(
                                    onPressed: () {
                                      showDialog<bool>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('ยกเลิกการซื้อ'),
                                              content: Text(
                                                  'ต้องการนำ ${userbasket![index].product_name.toString()} ออกใช้ไหม?'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: const Text(
                                                    "ไม่",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Art_Services()
                                                        .deleteonlybasket(
                                                            userbasket![index]
                                                                .user_basket_id)
                                                        .then((value) => {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "ลบสินค้า ${userbasket![index].product_name} เรียบร้อย",
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
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0),
                                                              _getBasket(),
                                                              Navigator.pop(
                                                                  context),
                                                            });
                                                  },
                                                  child: const Text("ใช่",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.delete)),
                                onTap: () {},
                              ),
                            ),
                          )),
                ),
              ],
            ),
          ),
        ));
  }
}
