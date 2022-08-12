// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/rider_myorderdetail.dart';
import 'package:project_bekery/screen/rider_orderdetail.dart';
import 'package:project_bekery/screen/rider_target_map.dart';

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
    Services().rider_getonlyExport_product(user_email.toString()).then((value) {
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
              showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('ออกจากระบบ'),
                      content: const Text('ต้องการที่จะออกจากระบบไหม?'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("ไม่"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                  builder: (context) => LoginPage()),
                              (_) => false,
                            );
                          },
                          child: const Text("ใช่"),
                        ),
                      ],
                    );
                  });
            },
          ),
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          title: Center(
              child: const Text(
            'รายการงานของฉัน',
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
                          title: Text(
                              '${DateFormat('วันที่ d เดือน MMMM ปี y', 'th').format(DateTime.parse('${user_order![index].date}'))}'),
                          subtitle: Text(
                              'สถานะของรายการ : ${user_order![index].order_status.toString()}'),
                          tileColor: Colors.orangeAccent,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return user_order_detail(
                                  user_order![index].order_id.toString(),
                                  user_order![index].total_price.toString());
                            }));
                          },
                        ),
                      ),
                    )),
          ),
        ));
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
              width: 150,
              child: FloatingActionButton.extended(
                heroTag: '1',
                onPressed: () {
                  Services()
                      .rider_getlocation_order(
                          widget.import_order_id.toString())
                      .then((value) {
                    List<Export_product>? user_order;
                    user_order = [];
                    user_order = value;
                    print(
                        'userLocation : ${user_order[0].user_latitude} ,  ${user_order[0].user_longitude}');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return rider_target_map(
                          double.parse(user_order![0].user_latitude.toString()),
                          double.parse(user_order[0].user_longitude.toString()),
                          user_order[0].order_id.toString());
                    }));
                  });
                },
                label: Text("ดูแผนที่"),
                icon: Icon(Icons.near_me),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 150,
              child: FloatingActionButton.extended(
                heroTag: '2',
                onPressed: () {
                  Services()
                      .rider_update_order('ยังไม่มีคนรับผิดชอบ',
                          'ยังไม่มีใครรับ', widget.import_order_id.toString())
                      .then((value) => {
                            Navigator.pop(context),
                            Fluttertoast.showToast(
                                msg: "ยกเลิกเรียบร้อย",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color.fromARGB(255, 255, 0, 0),
                                textColor: Colors.white,
                                fontSize: 16.0),
                          });
                },
                label: Text("ยกเลิก"),
                icon: Icon(Icons.near_me),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text('รายละเอียดการสั่งซื้อ'),
          backgroundColor: Colors.blueAccent,
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
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
        ));
  }
}
