import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_bekery/model/user_basket.dart';
import 'package:project_bekery/model/user_maps.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/user_order.dart';
import 'package:project_bekery/screen/user_welcome.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';
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
  List<User_mymaps>? usermap;
  late int length;
  int simpletotal = 0;
  int disconttotal = 0;
  @override
  void initState() {
    super.initState();
    userbasket = [];
    _getBasket();
    _getonlyuser();
    _getlocationuser();
  }

  _getBasket() {
    print("function working");
    Art_Services().getuserbasket(widget.email.toString()).then((basket) {
      setState(() {
        userbasket = basket;
        length = basket.length;
      });
      _gettotalprice(length);
      _gettotaldiscount(length);
      print("Length ${basket.length}");
    });
  }

  _getonlyuser() {
    print("function working");
    Art_Services().geyonlyuser(widget.email.toString()).then((user) {
      setState(() {
        _user = user;
      });
    });
  }

  _getImportorder(length) {
    Utils(context).startLoading();
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
      print('ราคารวม ----> [${userbasket![i].totalprice.toString()}]');
      print('วันเวลาที่สั่ง ----> [${DateTime.now()}]');
      setState(() {
        Import_totalprice += int.parse(userbasket![i].totalprice.toString());
      });
      Art_Services().addOrderdtail(
        Import_order_id.toString(),
        userbasket![i].user_basket_product_id.toString(),
        userbasket![i].user_basket_quantity.toString(),
        userbasket![i].user_basket_price.toString(),
        userbasket![i].basket_product_promotionname.toString(),
        userbasket![i].basket_product_promotionvalue.toString(),
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
        usermap![0].user_latitude.toString(),
        usermap![0].user_longitude.toString(),
        'ยังไม่มีคนรับผิดชอบ'.toString(),
        Import_totalprice.toString(),
        'รอการยืนยันจาก Admin',
        DateTime.now().toString(),
        length.toString());
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
    simpletotal = 0;
    for (int i = 0; i < length; i++) {
      setState(() {
        simpletotal += int.parse(userbasket![i].simpletotal.toString());
      });
    }
  }

  _gettotaldiscount(length) {
    disconttotal = 0;
    for (int i = 0; i < length; i++) {
      setState(() {
        print('ส่วนลด : ${userbasket![i].discount}');
        disconttotal += int.parse(userbasket![i].discount.toString());
      });
    }
  }

  _getlocationuser() async {
    String user_email = await SessionManager().get("email");
    await Art_Services().getlocation(user_email).then((value) {
      setState(() {
        if (value == null) {
          usermap = null;
        } else {
          usermap = value;
        }
      });
    });
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
                if (usermap?.length == 0) {
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
                          title: const Text('ยืนยันการสั่งซื้อ'),
                          content: Text('ยืนยันการสั่งซื้อใช้ไหม?'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                "ไม่",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print('USERMAP ==> ${usermap!.length}');
                                if (usermap?.length == 0) {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: "โปรดยืนยันตำแหน่งก่อน",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  _getImportorder(length);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Orderpage();
                                  }));
                                }
                              },
                              child: const Text("ใช่",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        );
                      });
                }
              },
              label: Text("ราคารวม : ${simpletotal.toString()}"),
              icon: Icon(Icons.shopping_bag),
              backgroundColor: Colors.red,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Orderpage();
              }));
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
              child: const Text(
            'รายการสินค้า',
            style: TextStyle(
                color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
              onPressed: () {
                _getBasket();
              },
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:
                        userbasket != null ? (userbasket?.length ?? 0) : 0,
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.all(5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        leading: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          imageUrl: userbasket![index].product_image.toString(),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),

                        /*Image(
                          image: NetworkImage(
                              userbasket![index].product_image.toString()),
                          width: 50,
                          height: 50,
                        ),*/
                        title: Text(userbasket![index].product_name.toString()),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'จำนวน : ${userbasket![index].user_basket_quantity.toString()}'),
                          ],
                        ),
                        tileColor: Colors.yellow,
                        trailing: IconButton(
                            onPressed: () {
                              showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('ยกเลิกการซื้อ'),
                                      content: Text(
                                          'ต้องการนำ ${userbasket![index].product_name.toString()} ออกใช้ไหม?'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text(
                                            "ไม่",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Utils(context).startLoading();
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
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  0,
                                                                  0),
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0),
                                                      _getBasket(),
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return cart_order_add(
                                                            widget.email);
                                                      }))
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
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                height: 90,
                child: Card(
                  elevation: 20,
                  color: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "รวมเบื้องต้น",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "${simpletotal}",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ส่วนลด ",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "- ${disconttotal}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ราคารวม ",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    "${simpletotal - disconttotal}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
