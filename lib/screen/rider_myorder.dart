// ignore_for_file: unused_import

import 'dart:convert';

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
import 'package:map_launcher/map_launcher.dart';
import 'package:project_bekery/login/login.dart';
import 'package:location/location.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/rider_myorderdetail.dart';
import 'package:project_bekery/screen/rider_orderdetail.dart';
import 'package:project_bekery/screen/rider_target_map.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';
import 'package:project_bekery/widgets/riderAppbar.dart';

class rider_myorder extends StatefulWidget {
  const rider_myorder({Key? key}) : super(key: key);

  @override
  _rider_myorderState createState() => _rider_myorderState();
}

class _rider_myorderState extends State<rider_myorder> {
  List<Export_product>? user_order;
  String? user_email;

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    user_order = [];
    _getImport_product();
  }

  _getImport_product() async {
    user_email = await SessionManager().get("email");
    print("User : ${user_email}");
    Art_Services()
        .rider_getonlyExport_product(user_email.toString(), 'ของกำลังส่ง')
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
        extendBodyBehindAppBar: true,
        body: SliderDrawer(
            appBar: SliderAppBar(
              drawerIconColor: Colors.blue,
              appBarHeight: 85,
              appBarColor: Colors.white,
              title: Container(
                child: Center(
                    child: const Text(
                  'รายการงานของฉัน',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            slider: RiderAppBar(),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color.fromARGB(255, 238, 238, 238),
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
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
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return user_order_detail(
                                          user_order![index]
                                              .order_id
                                              .toString(),
                                          user_order![index]
                                              .total_price
                                              .toString());
                                    }));
                                  },
                                ),
                                title: Text(
                                    '${DateFormat('วันที่ d เดือน MMMM ปี y', 'th').format(DateTime.parse('${user_order![index].date}'))}'),
                                subtitle: Text(
                                    'สถานะของรายการ : ${user_order![index].order_status.toString()}'),
                                tileColor: Colors.white,
                              ),
                            ])),
                      ),
                    )),
                  ),
                ))));
  }
}

class user_order_detail extends StatefulWidget {
  final String import_order_id, Import_product_pricetotal;
  const user_order_detail(this.import_order_id, this.Import_product_pricetotal,
      {Key? key})
      : super(key: key);

  @override
  State<user_order_detail> createState() => _import_order_detailState();
}

class _import_order_detailState extends State<user_order_detail> {
  List<Export_product_detail>? _Import_product;
  Location location = Location();

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
              width: 150,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.green,
                heroTag: '1',
                onPressed: () async {
                  Utils(context).startLoading();
                  String email = await SessionManager().get("email");
                  Art_Services()
                      .rider_update_order(email.toString(), 'ส่งเรียบร้อย',
                          widget.import_order_id.toString())
                      .then((value) => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return rider_myorder();
                            })),
                            Fluttertoast.showToast(
                                msg: "ยืนยันการส่งเรียบร้อย",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color.fromARGB(255, 0, 255, 4),
                                textColor: Colors.white,
                                fontSize: 16.0),
                          });
                },
                label: Text("ยืนยันการสั่งซื้อ"),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 150,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.red,
                heroTag: '2',
                onPressed: () {
                  Utils(context).startLoading();
                  Art_Services()
                      .waitcancel_order(
                          widget.import_order_id, 'ยกเลิกโดยrider')
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
                              return rider_myorder();
                            })),
                          });
                },
                label: Text("ขอยกเลิกจากแอดมิน"),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.map,
                color: Colors.blue,
              ),
              onPressed: () async {
                double? user_latitude, user_longitude;
                location.requestService().then((value) {
                  print('requestService : ${value}');
                });
                location.serviceEnabled().then((value) {
                  print('serviceEnabled : ${value}');
                });
                final availableMaps = await MapLauncher.installedMaps;
                print(availableMaps);
                location.getLocation().then((value) {
                  print('user_latitude : ${value.latitude}');
                  print('user_longitude : ${value.longitude}');
                  setState(() {
                    user_latitude = value.latitude;
                    user_longitude = value.longitude;
                  });
                  Art_Services()
                      .rider_getlocation_order(
                          widget.import_order_id.toString())
                      .then((value) async {
                    List<Export_product>? user_order;
                    user_order = [];
                    user_order = value;
                    await availableMaps.first.showDirections(
                        destination: Coords(
                            double.parse(
                                user_order[0].user_latitude.toString()),
                            double.parse(
                                user_order[0].user_longitude.toString())),
                        origin: Coords(
                          user_latitude!,
                          user_longitude!,
                        ));
                  });
                });
              },
            ),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
              child: const Text(
            'รายละเอียดการสั่งซื้อ',
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

class rider_history extends StatefulWidget {
  const rider_history({Key? key}) : super(key: key);

  @override
  State<rider_history> createState() => _rider_historyState();
}

class _rider_historyState extends State<rider_history> {
  List<Export_product>? user_order;
  String? user_email;

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    user_order = [];
    _getImport_product();
  }

  _getImport_product() async {
    user_email = await SessionManager().get("email");
    print("User : ${user_email}");
    Art_Services()
        .rider_getonlyExport_product(user_email.toString(), 'ส่งเรียบร้อย')
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
              appBarHeight: 85,
              appBarColor: Colors.white,
              title: Container(
                child: Center(
                    child: const Text(
                  'ประวัติการส่งของ',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            slider: RiderAppBar(),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color.fromARGB(255, 238, 238, 238),
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                          user_order != null ? (user_order?.length ?? 0) : 0,
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return user_order_history_detail(
                                                user_order![index]
                                                    .order_id
                                                    .toString(),
                                                user_order![index]
                                                    .total_price
                                                    .toString());
                                          }));
                                        },
                                      ),
                                      title: Text(
                                          '${DateFormat('วันที่ d เดือน MMMM ปี y', 'th').format(DateTime.parse('${user_order![index].date}'))}'),
                                      subtitle: Text(
                                          'สถานะของรายการ : ${user_order![index].order_status.toString()}'),
                                      tileColor: Colors.white,
                                    ),
                                  ]),
                                ),
                              )),
                        ),
                      ),
                    )))));
  }
}

class user_order_history_detail extends StatefulWidget {
  final String import_order_id, Import_product_pricetotal;
  const user_order_history_detail(
      this.import_order_id, this.Import_product_pricetotal,
      {Key? key})
      : super(key: key);

  @override
  State<user_order_history_detail> createState() =>
      user_order_history_detailState();
}

class user_order_history_detailState extends State<user_order_history_detail> {
  List<Export_product_detail>? _Import_product;
  Location location = Location();

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
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
              child: const Text(
            'รายละเอียดการสั่งซื้อ',
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
