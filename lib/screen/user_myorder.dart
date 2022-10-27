// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/user_myorderdetail.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';
import 'package:project_bekery/widgets/userAppbar.dart';
import 'package:http/http.dart' as http;

enum Menu { itemOne, itemTwo, itemThree }

class user_order extends StatefulWidget {
  const user_order({Key? key}) : super(key: key);

  @override
  _user_orderState createState() => _user_orderState();
}

class _user_orderState extends State<user_order> {
  String title = 'รายการของฉัน';
  List<Export_product>? user_order;
  String? user_email;
  String _selectedMenu = '';

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    user_order = [];
    _getImport_product('ส่งเรียบร้อย');
  }

  _getImport_product(order_status) async {
    user_email = await SessionManager().get("email");
    print("User : ${user_email}");
    print('Order_status : ${order_status}');
    Art_Services()
        .gatonlyExport_product(user_email.toString(), order_status.toString())
        .then((value) {
      setState(() {
        user_order = value;
      });

      print('จำนวข้อมูล : ${value.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.blue,
          trailing: PopupMenuButton(
            icon: Icon(
              Icons.filter_alt_outlined,
              color: Colors.blue,
            ),
            onSelected: (value) {
              print('สถานะ : ${value.toString()}');
              _getImport_product(value);
              title = value.toString();
            },
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(
                  child: Text("ยังไม่มีใครรับ"),
                  value: 'ยังไม่มีใครรับ',
                ),
                PopupMenuItem(
                  child: Text("ส่งเรียบร้อย"),
                  value: 'ส่งเรียบร้อย',
                ),
                PopupMenuItem(
                  child: Text("รายการที่ยกเลิก"),
                  value: 'รายการที่ยกเลิก',
                ),
                PopupMenuItem(
                  child: Text("ของกำลังส่ง"),
                  value: 'ของกำลังส่ง',
                ),
                PopupMenuItem(
                  child: Text("รอการยืนยันจาก Admin"),
                  value: 'รอการยืนยันจาก Admin',
                ),
                PopupMenuItem(
                  child: Text("รอการยืนยันการเเพ็คของ"),
                  value: 'รอการยืนยันการเเพ็คของ',
                )
              ];
            },
          ),
          appBarHeight: 85,
          appBarColor: Colors.white,
          title: Container(
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        slider: UserAppBar(),
        child: Container(
          padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: double.infinity,
            color: Color.fromARGB(255, 238, 238, 238),
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: user_order != null ? (user_order?.length ?? 0) : 0,
              itemBuilder: (_, index) => Center(
               child: Container(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 8.0, bottom: 8.0),
                              child: Container(
                                  child: Card(
                                      elevation: 20,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(children: [
                    ListTile(
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          if (user_order![index].order_status ==
                              'รอการยืนยันจาก Admin') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return user_order_detail_cancel(
                                user_order![index].order_id.toString(),
                                user_order![index].total_price.toString(),
                                user_order![index]
                                    .order_responsible_person
                                    .toString(),
                                user_order![index].date.toString(),
                              );
                            }));
                          } else if (user_order![index].order_status ==
                              'รอการยืนยันการเเพ็คของ') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return user_order_detail_waitcancel(
                                user_order![index].order_id.toString(),
                                user_order![index].total_price.toString(),
                                user_order![index]
                                    .order_responsible_person
                                    .toString(),
                                user_order![index].date.toString(),
                              );
                            }));
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return user_order_detail_onlysee(
                                user_order![index].order_id.toString(),
                                user_order![index].total_price.toString(),
                                user_order![index]
                                    .order_responsible_person
                                    .toString(),
                                user_order![index].date.toString(),
                              );
                            }));
                          }
                        },
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      title: Text(
                          '${DateFormat('วันที่ d เดือน MMMM ปี y', 'th').format(DateTime.parse('${user_order![index].date}'))}'),
                      subtitle: Text(
                          'สถานะของรายการ : ${user_order![index].order_status.toString()}'),
                    ),
                  ]),
                ),
              ),
            )),
      ),
    ))));
  }
}

class user_order_detail_onlysee extends StatefulWidget {
  final String import_order_id,
      Import_product_pricetotal,
      order_responsible_person,
      orderdate;
  const user_order_detail_onlysee(
      this.import_order_id,
      this.Import_product_pricetotal,
      this.order_responsible_person,
      this.orderdate,
      {Key? key})
      : super(key: key);

  @override
  State<user_order_detail_onlysee> createState() =>
      user_order_detail_onlyseeState();
}

class user_order_detail_onlyseeState extends State<user_order_detail_onlysee> {
  List<Export_product_detail>? _Import_product;
  @override
  void initState() {
    super.initState();
    _Import_product = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Art_Services()
        .getuserorder_detail(widget.import_order_id)
        .then((Import_detail) {
      setState(() {
        _Import_product = Import_detail;
      });

      print('จำนวข้อมูล : ${Import_detail.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
              child: const Text(
            'รายละเอียด',
            style: TextStyle(
                color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
        backgroundColor: Colors.grey[100],
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 238, 238, 238),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Container(
                    height: 600,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('${widget.import_order_id}'),
                          SizedBox(height: 20),
                          Text('สั่งในวันที่ : ${widget.orderdate}'),
                          SizedBox(height: 20),
                          Text(
                              'รับผิดชอบโดย :${widget.order_responsible_person}'),
                          SizedBox(height: 20),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _Import_product != null
                                ? (_Import_product?.length ?? 0)
                                : 0,
                            itemBuilder: (_, index) => Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'ชื่อสินค้า : ${_Import_product![index].product_name}'),
                                      Text(
                                          'จำนวน : ${_Import_product![index].product_amount}'),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          'ราคาต่อชิ้น : ${_Import_product![index].product_price}'),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${_Import_product![index].product_promotion_name}'),
                                      Text(
                                          'ราคารวม : ${_Import_product![index].totalprice}'),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Divider(color: Colors.black)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  'ราคารวม : ${widget.Import_product_pricetotal}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ));
  }
}

class user_order_detail_cancel extends StatefulWidget {
  final String import_order_id,
      Import_product_pricetotal,
      order_responsible_person,
      orderdate;
  const user_order_detail_cancel(
      this.import_order_id,
      this.Import_product_pricetotal,
      this.order_responsible_person,
      this.orderdate,
      {Key? key})
      : super(key: key);

  @override
  State<user_order_detail_cancel> createState() =>
      user_order_detaill_cancelState();
}

class user_order_detaill_cancelState extends State<user_order_detail_cancel> {
  List<Export_product_detail>? _Import_product;
  int? datalength;
  @override
  void initState() {
    super.initState();
    _Import_product = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Art_Services()
        .getuserorder_detail(widget.import_order_id)
        .then((Import_detail) {
      setState(() {
        _Import_product = Import_detail;
        datalength = Import_detail.length;
      });

      print('จำนวข้อมูล : ${Import_detail.length}');
    });
  }

  _updateImport(product_name, import_product) async {
    print('UPDATE ACTIVATION');
    print('ชื่อสินค้า : ${product_name}');
    print('จำนวนการคืน : ${import_product}');
    try {
      var url = Uri.parse('https://projectart434.000webhostapp.com/');
      print('funtion working....');
      var map = <String, dynamic>{};
      map["action"] = "ADD_PRODUCT";
      map['sql'] =
          "UPDATE product SET  product_quantity = product_quantity + ${import_product} WHERE product_name = '${product_name}'";
      final response = await http.post(url, body: map);
      print("AddProduct >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.greenAccent,
          elevation: 0,
          title: Center(
              child: const Text(
            'ประวัติการนำเข้า',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
        backgroundColor: Colors.grey[100],
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('สั่งในวันที่ : ${widget.orderdate}'),
                            SizedBox(height: 20),
                            Text(
                                'รับผิดชอบโดย :${widget.order_responsible_person}'),
                            SizedBox(height: 20),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _Import_product != null
                                  ? (_Import_product?.length ?? 0)
                                  : 0,
                              itemBuilder: (_, index) => Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'ชื่อสินค้า : ${_Import_product![index].product_name}'),
                                        Text(
                                            'จำนวน : ${_Import_product![index].product_amount}'),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            'ราคาต่อชิ้น : ${_Import_product![index].product_price}'),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${_Import_product![index].product_promotion_name}'),
                                        Text(
                                            'ราคารวม : ${_Import_product![index].totalprice}'),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Divider(color: Colors.black)
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    'ราคารวม : ${widget.Import_product_pricetotal}'),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(color: Colors.black),
                            SizedBox(height: 5),
                            SizedBox(
                              width: 250,
                              child: FloatingActionButton.extended(
                                icon: Icon(Icons.cancel),
                                backgroundColor: Colors.redAccent,
                                heroTag: '1',
                                onPressed: () {
                                  showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title:
                                              const Text('ยกเลิกการซื้อสินค้า'),
                                          content: const Text(
                                              'ต้องการยกเลิกรายการนี้ใช้ไหม?'),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text("ไม่"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Utils(context).startLoading();
                                                for (var i = 0;
                                                    i < datalength!;
                                                    i++) {
                                                  _updateImport(
                                                    _Import_product![i]
                                                        .product_name
                                                        .toString(),
                                                    int.parse(
                                                        _Import_product![i]
                                                            .product_amount
                                                            .toString()),
                                                  );
                                                }
                                                Art_Services()
                                                    .cancel_order(
                                                        widget.import_order_id)
                                                    .then((value) => {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "ยกเลิกการสั่งเรียบร้อย",
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
                                                                  Colors.white,
                                                              fontSize: 16.0),
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return user_order();
                                                          }))
                                                        });
                                              },
                                              child: const Text("ใช่"),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                label: Text('ยกเลิกการสั่งสินค้า'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )),
              ),
            )));
  }
}

class user_order_detail_waitcancel extends StatefulWidget {
  final String import_order_id,
      Import_product_pricetotal,
      order_responsible_person,
      orderdate;
  const user_order_detail_waitcancel(
      this.import_order_id,
      this.Import_product_pricetotal,
      this.order_responsible_person,
      this.orderdate,
      {Key? key})
      : super(key: key);

  @override
  State<user_order_detail_waitcancel> createState() =>
      user_order_detaill_waitcancelState();
}

class user_order_detaill_waitcancelState
    extends State<user_order_detail_waitcancel> {
  List<Export_product_detail>? _Import_product;
  @override
  void initState() {
    super.initState();
    _Import_product = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Art_Services()
        .getuserorder_detail(widget.import_order_id)
        .then((Import_detail) {
      setState(() {
        _Import_product = Import_detail;
      });

      print('จำนวข้อมูล : ${Import_detail.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: FloatingActionButton.extended(
                icon: Icon(Icons.cancel),
                backgroundColor: Colors.redAccent,
                heroTag: '1',
                onPressed: () {
                  Art_Services()
                      .waitcancel_order(
                          widget.import_order_id, 'รอการยืนยันจาก Admin')
                      .then((value) => {
                            Fluttertoast.showToast(
                                msg: "ขอยกเลิกการสั่งเรียบร้อย",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color.fromARGB(255, 255, 0, 0),
                                textColor: Colors.white,
                                fontSize: 16.0),
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return user_order();
                            })),
                          });
                },
                label: Text('ยกเลิกการสั่งสินค้า'),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.greenAccent,
          elevation: 0,
          title: Center(
              child: const Text(
            'ประวัติการนำเข้า',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
        backgroundColor: Colors.grey[100],
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: [
                  Container(
                    height: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('${widget.import_order_id}'),
                          SizedBox(height: 20),
                          Text('สั่งในวันที่ : ${widget.orderdate}'),
                          SizedBox(height: 20),
                          Text(
                              'รับผิดชอบโดย :${widget.order_responsible_person}'),
                          SizedBox(height: 20),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _Import_product != null
                                ? (_Import_product?.length ?? 0)
                                : 0,
                            itemBuilder: (_, index) => Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'ชื่อสินค้า : ${_Import_product![index].product_name}'),
                                      Text(
                                          'จำนวน : ${_Import_product![index].product_amount}'),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          'ราคาต่อชิ้น : ${_Import_product![index].product_price}'),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  'ราคารวม : ${widget.Import_product_pricetotal}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            )));
  }
}
