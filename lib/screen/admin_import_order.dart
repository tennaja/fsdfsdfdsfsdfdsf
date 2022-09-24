import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/import_detail.dart';
import 'package:project_bekery/model/import_product.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_product.dart';
import 'package:project_bekery/screen/float_add_order.dart';
import 'package:http/http.dart' as http;
import 'package:project_bekery/widgets/adminAppbar.dart';

class admin_import_order extends StatefulWidget {
  const admin_import_order({Key? key}) : super(key: key);

  @override
  State<admin_import_order> createState() => _admin_import_orderState();
}

class _admin_import_orderState extends State<admin_import_order> {
  List<Import_product>? _Import_product;
  List<Import_product>? _filterImport_product;

  @override
  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    _Import_product = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Art_Services().getimport_product('สินค้ายังไม่ครบ').then((Import_product) {
      setState(() {
        _Import_product = Import_product;

        _filterImport_product = Import_product;
      });

      print('จำนวข้อมูล : ${Import_product.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SliderDrawer(
          appBar: SliderAppBar(
            appBarHeight: 85,
            appBarColor: Color(0xFFff9e00),
            title: Container(
              child: Center(
                  child: const Text(
                'รายงานนำเข้าสินค้า',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          slider: ComplexDrawer(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _Import_product != null
                      ? (_Import_product?.length ?? 0)
                      : 0,
                  itemBuilder: (_, index) => Center(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 8.0),
                        child: Container(
                        child: Card( elevation: 20,
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                            child: Column(
                              children: [ ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Text(
                                    '${DateFormat('วันที่ d เดือน MMMM ปี y', 'th').format(DateTime.parse('${_Import_product![index].Import_date}'))}'),
                                subtitle: Text(
                                    'ที่มา : ${_Import_product![index].source_name.toString()}'),
                                tileColor: Colors.yellow,
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return import_order_detail(
                                        _Import_product![index]
                                            .Import_order_id
                                            .toString(),
                                        _Import_product![index]
                                            .Import_product_pricetotal
                                            .toString());
                                  }));
                                },
                              ),
                            ]),
                          ),
                        ),
                      )),
            ),
          ),
          ))));
  }
}

class adminhistoryimport extends StatefulWidget {
  const adminhistoryimport({Key? key}) : super(key: key);

  @override
  State<adminhistoryimport> createState() => _adminhistoryimportState();
}

_updateImport(
  product_name,
  import_product,
) async {
  try {
    var url = Uri.parse('https://artfinalproject.000webhostapp.com/');
    print('funtion working....');
    var map = <String, dynamic>{};
    map["action"] = "ADD_PRODUCT";
    map['sql'] =
        "UPDATE product SET  product_quantity = product_quantity + ${import_product},import_product = import_product + ${import_product} WHERE product_name = '${product_name}'";
    final response = await http.post(url, body: map);
    print("AddProduct >> Response:: ${response.body}");
    return response.body;
  } catch (e) {
    return 'error';
  }
}

class _adminhistoryimportState extends State<adminhistoryimport> {
  List<Import_product>? _Import_product;
  List<Import_product>? _filterImport_product;

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    _Import_product = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    String where = 'ส่งแล้ว';
    Art_Services().getimport_product(where).then((Import_product) {
      setState(() {
        _Import_product = Import_product;

        _filterImport_product = Import_product;
      });

      print('จำนวข้อมูล : ${Import_product.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      appBar: SliderAppBar(
        appBarHeight: 85,
        appBarColor: Color(0xFFff9100),
        title: Container(
          child: Center(
              child: const Text(
            'ประวัติการนำเข้าสินค้า',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      slider: ComplexDrawer(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:
                  _Import_product != null ? (_Import_product?.length ?? 0) : 0,
              itemBuilder: (_, index) => Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 8.0),
                        child: Container(
                    child: Card(
                       elevation: 20,
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      
                          
                          child: Column(
                            children: [
                             ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              title: Text(
                                  'วันที่สั่ง : ${_Import_product![index].Import_date.toString()}'),
                              subtitle: Text(
                                  'ที่มา : ${_Import_product![index].source_name.toString()}'),
                              tileColor: Colors.yellow,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return import_history_detail(
                                      _Import_product![index]
                                          .Import_order_id
                                          .toString(),
                                      _Import_product![index]
                                          .Import_product_pricetotal
                                          .toString());
                                }));
                              },
                            ),
                          ]),
                        ),
                      ),
                    ),
                  )),
        ),
      ))));
    
  }
}

class import_order_detail extends StatefulWidget {
  final String import_order_id, Import_product_pricetotal;
  const import_order_detail(
      this.import_order_id, this.Import_product_pricetotal,
      {Key? key})
      : super(key: key);

  @override
  State<import_order_detail> createState() => _import_order_detailState();
}

class _import_order_detailState extends State<import_order_detail> {
  List<Import_detail>? _Import_product;
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
        .getimport_detail(widget.import_order_id)
        .then((Import_detail) {
      setState(() {
        _Import_product = Import_detail;

        datalength = Import_detail.length;
      });

      print('จำนวข้อมูล : ${Import_detail.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.green,
                heroTag: '1',
                onPressed: () {
                  for (var i = 0; i < datalength!; i++) {
                    _updateImport(
                      _Import_product![i].product_name.toString(),
                      int.parse(_Import_product![i]
                          .basket_product_quantity
                          .toString()),
                    );
                  }
                  Art_Services()
                      .submit_order(widget.import_order_id)
                      .then((value) => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return admin_import_order();
                            })),
                            Fluttertoast.showToast(
                                msg: "ยืนยันการรับสินค้าเรียบร้อย",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    Color.fromARGB(255, 0, 255, 47),
                                textColor: Colors.white,
                                fontSize: 16.0),
                          });
                },
                label: Text("ยืนยันการรับ"),
                icon: Icon(Icons.near_me),
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
                  Art_Services()
                      .deleteorderdetail(widget.import_order_id)
                      .then((value) => {
                            Art_Services()
                                .deleteorder(widget.import_order_id)
                                .then((value) => {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return admin_import_order();
                                      })),
                                      Fluttertoast.showToast(
                                          msg: "ลบข้อมูลเสร็จสิ้น",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0),
                                    })
                          });
                },
                label: Text("ยกเลิกการรับ"),
                icon: Icon(Icons.near_me),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('รายละเอียดการสั่งซื้อ'),
          backgroundColor: Color(0xFFff9e00),
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
                                        'จำนวน : ${_Import_product![index].basket_product_quantity}'),
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

class import_history_detail extends StatefulWidget {
  final String import_order_id, Import_product_pricetotal;
  const import_history_detail(
      this.import_order_id, this.Import_product_pricetotal,
      {Key? key})
      : super(key: key);

  @override
  State<import_history_detail> createState() => _import_history_detailState();
}

class _import_history_detailState extends State<import_history_detail> {
  List<Import_detail>? _Import_product;
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
        .getimport_detail(widget.import_order_id)
        .then((Import_detail) {
      setState(() {
        _Import_product = Import_detail;

        datalength = Import_detail.length;
      });

      print('จำนวข้อมูล : ${Import_detail.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('รายละเอียดการสั่งซื้อ'),
          backgroundColor: Color(0xFFff9100),
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
                                        'จำนวน : ${_Import_product![index].basket_product_quantity}'),
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
