// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/user_myorderdetail.dart';

enum Menu { itemOne, itemTwo, itemThree }

class user_order extends StatefulWidget {
  const user_order({Key? key}) : super(key: key);

  @override
  _user_orderState createState() => _user_orderState();
}

class _user_orderState extends State<user_order> {
  List<Export_product>? user_order;
  String? user_email;
  String _selectedMenu = '';

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    user_order = [];
    _getImport_product('ยังไม่มีใครรับ');
  }

  _getImport_product(order_status) async {
    user_email = await SessionManager().get("email");
    print("User : ${user_email}");
    Services()
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
          actions: <Widget>[
            // This button presents popup menu items.
            PopupMenuButton(
              icon: Icon(
                Icons.filter_alt_outlined,
                color: Colors.black,
              ),
              onSelected: (value) {
                print('สถานะ : ${value.toString()}');
                _getImport_product(value);
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
                  )
                ];
              },
            )
          ],
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          title: Center(
              child: const Text(
            'รายการสินค้าของฉัน',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.orangeAccent.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: user_order != null ? (user_order?.length ?? 0) : 0,
                itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              if (user_order![index].order_status ==
                                  'ยังไม่มีใครรับ') {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return user_order_detail_cancel(
                                      user_order![index].order_id.toString(),
                                      user_order![index]
                                          .total_price
                                          .toString());
                                }));
                              } else {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return user_order_detail_onlysee(
                                      user_order![index].order_id.toString(),
                                      user_order![index]
                                          .total_price
                                          .toString());
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
                          tileColor: Colors.orangeAccent,
                        ),
                      ),
                    )),
          ),
        ));
  }
}

class user_order_detail_onlysee extends StatefulWidget {
  final String import_order_id, Import_product_pricetotal;
  const user_order_detail_onlysee(
      this.import_order_id, this.Import_product_pricetotal,
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
    Services()
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
            'ประวัติการนำเข้า',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
        backgroundColor: Colors.grey[100],
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.orangeAccent.withOpacity(0.5),
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

class user_order_detail_cancel extends StatefulWidget {
  final String import_order_id, Import_product_pricetotal;
  const user_order_detail_cancel(
      this.import_order_id, this.Import_product_pricetotal,
      {Key? key})
      : super(key: key);

  @override
  State<user_order_detail_cancel> createState() =>
      user_order_detaill_cancelState();
}

class user_order_detaill_cancelState extends State<user_order_detail_cancel> {
  List<Export_product_detail>? _Import_product;
  @override
  void initState() {
    super.initState();
    _Import_product = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Services()
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
                backgroundColor: Color.fromARGB(255, 255, 0, 0),
                heroTag: '1',
                onPressed: () {},
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
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.orangeAccent.withOpacity(0.5),
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
          color: Colors.orangeAccent.withOpacity(0.5),
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
