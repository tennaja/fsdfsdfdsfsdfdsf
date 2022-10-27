import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';
import 'package:http/http.dart' as http;

class admin_ordercancellist extends StatefulWidget {
  const admin_ordercancellist({Key? key}) : super(key: key);

  @override
  State<admin_ordercancellist> createState() => _admin_ordercancellistState();
}

class _admin_ordercancellistState extends State<admin_ordercancellist> {
  List<Export_product>? _Export_product;
  List<Export_product>? _filterImport_product;
  List<int> datalength = [];
  int? datadetaillength;
  String title = 'รอการยกเลิกจากแอดมิน';

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    _Export_product = [];
    _getImport_product('ยกเลิกโดยrider');
  }

  _getImport_product(where) {
    print("function working");
    Art_Services().gatallExport_product(where).then((value) {
      setState(() {
        _Export_product = value;
        datadetaillength = value.length;
      });
      print('จำนวข้อมูล : ${value.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF231942),
          title: Text(title),
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
              ),
              onSelected: (value) {
                print('สถานะ : ${value.toString()}');
                _getImport_product(value);
                title = value.toString();
              },
              itemBuilder: (BuildContext bc) {
                return const [
                  PopupMenuItem(
                    child: Text("ยกเลิกโดยrider"),
                    value: 'ยกเลิกโดยrider',
                  ),
                  PopupMenuItem(
                    child: Text("ยกเลิกโดยuser"),
                    value: 'ยกเลิกโดยuser',
                  ),
                ];
              },
            ),
          ],
        ),
        drawer: /*AdminAppBar(),*/
            ComplexDrawer(),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: datalength == 0
                ? Container(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/correct_image.png',
                        height: 100,
                        width: 100,
                      ),
                      Text('รับงานทั้งหมดเรียบร้อยแล้ว')
                    ],
                  ))
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _Export_product != null
                        ? (_Export_product?.length ?? 0)
                        : 0,
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
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.cancel,
                                        color: Color.fromARGB(255, 255, 0, 0),
                                      ),
                                      title: Text(
                                          'สั่งซื้อโดย : ${_Export_product![index].user_name} ${_Export_product![index].user_surname}'),
                                      subtitle: Text(
                                          'จำนวนรายการ : ${_Export_product![index].product_amount}'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            'วันที่สั่ง ${_Export_product![index].date}',
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.discount_rounded,
                                              color: Colors.lightGreen,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                '${_Export_product![index].total_price} .-  '),
                                          ],
                                        )
                                      ],
                                    ),
                                    ButtonBar(
                                        alignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_Export_product![index]
                                                      .order_status ==
                                                  'ยกเลิกโดยrider') {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return admin_oderlist_detail(
                                                      _Export_product![index]
                                                          .order_id
                                                          .toString(),
                                                      _Export_product![index]
                                                          .total_price
                                                          .toString(),
                                                      _Export_product![index]
                                                          .order_responsible_person
                                                          .toString());
                                                }));
                                              } else {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return admin_oderlist_user_detail(
                                                      _Export_product![index]
                                                          .order_id
                                                          .toString(),
                                                      _Export_product![index]
                                                          .total_price
                                                          .toString(),
                                                      _Export_product![index]
                                                          .order_responsible_person
                                                          .toString());
                                                }));
                                              }
                                            },
                                            child: const Text('รายละเอียด >'),
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0)),
                                                primary: Colors.red),
                                          ),
                                        ]),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ))));
  }
}

/*

Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return admin_oderlist_detail(
                                            _Export_product![index]
                                                .order_id
                                                .toString(),
                                            _Export_product![index]
                                                .total_price
                                                .toString(),
                                            _Export_product![index]
                                                .order_responsible_person
                                                .toString());
                                      }));

*/
class admin_oderlist_detail extends StatefulWidget {
  final String order_id, total_price, order_responsible_person;
  const admin_oderlist_detail(
      this.order_id, this.total_price, this.order_responsible_person,
      {Key? key})
      : super(key: key);

  @override
  State<admin_oderlist_detail> createState() => _admin_oderlist_detailState();
}

class _admin_oderlist_detailState extends State<admin_oderlist_detail> {
  List<Export_product_detail>? _orderdetail;
  int datalenght = 0;
  @override
  void initState() {
    super.initState();
    _orderdetail = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Art_Services().getorder_detail(widget.order_id).then((value) {
      setState(() {
        _orderdetail = value;
        datalenght = value.length;
      });
      print('จำนวข้อมูล : ${value.length}');
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: 1,
                onPressed: () async {
                  Art_Services()
                      .rider_update_order('ยังไม่มีคนรับผิดชอบ',
                          'ยังไม่มีใครรับ', widget.order_id.toString())
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "ส่งงานให้คนอื่นรับแทนเรียบร้อย",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 9, 255, 0),
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return admin_ordercancellist();
                    }));
                  });
                },
                label: Text(
                  "มอบหมายงานให้คนอื่น",
                  style: TextStyle(fontSize: 12),
                ),
                icon: Icon(Icons.near_me),
                backgroundColor: Colors.green,
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                heroTag: 2,
                onPressed: () async {
                  for (var i = 0; i < datalenght; i++) {
                    print('ชื่อสินค้า : ${_orderdetail![i].product_name}');
                    print(
                        'จำนวนของสินค้า : ${_orderdetail![i].product_amount}');
                    _updateImport(
                      _orderdetail![i].product_name.toString(),
                      int.parse(_orderdetail![i].product_amount.toString()),
                    );
                  }
                  Art_Services().cancel_order(widget.order_id).then((value) {
                    Fluttertoast.showToast(
                        msg: "คืนของเข้าคลังเรียบร้อย",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 255, 0, 0),
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return admin_ordercancellist();
                    }));
                  });
                },
                label: Text("ยกเลิกออเดอร์"),
                icon: Icon(Icons.near_me),
                backgroundColor: Color(0xFFba181b),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('รายละเอียดการขาย'),
          backgroundColor: Color(0xFF231942),
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
                        Text('${widget.order_id}'),
                        SizedBox(height: 20),
                        Text(
                            'คนรับผิดชอบงาน :  ${widget.order_responsible_person}'),
                        SizedBox(height: 20),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _orderdetail != null
                              ? (_orderdetail?.length ?? 0)
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
                                        'ชื่อสินค้า : ${_orderdetail![index].product_name}'),
                                    Text(
                                        'จำนวน : ${_orderdetail![index].product_amount}'),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        'ราคาต่อชิ้น : ${_orderdetail![index].product_price}'),
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
                            Text('ราคารวม : ${widget.total_price}'),
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

class admin_oderlist_user_detail extends StatefulWidget {
  final String order_id, total_price, order_responsible_person;
  const admin_oderlist_user_detail(
      this.order_id, this.total_price, this.order_responsible_person,
      {Key? key})
      : super(key: key);

  @override
  State<admin_oderlist_user_detail> createState() =>
      _admin_oderlist_user_detailState();
}

class _admin_oderlist_user_detailState
    extends State<admin_oderlist_user_detail> {
  List<Export_product_detail>? _orderdetail;
  int datalenght = 0;
  @override
  void initState() {
    super.initState();
    _orderdetail = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Art_Services().getorder_detail(widget.order_id).then((value) {
      setState(() {
        _orderdetail = value;
        datalenght = value.length;
      });
      print('จำนวข้อมูล : ${value.length}');
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: 1,
                onPressed: () async {
                  Art_Services()
                      .waitcancel_order(widget.order_id, 'ยกเลิกโดยuser')
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "ส่งงานให้คนอื่นรับแทนเรียบร้อย",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 9, 255, 0),
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return admin_ordercancellist();
                    }));
                  });
                },
                label: Text(
                  "ไม่อนุมัติให้ยกเลิก",
                  style: TextStyle(fontSize: 12),
                ),
                icon: Icon(Icons.near_me),
                backgroundColor: Colors.green,
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                heroTag: 2,
                onPressed: () async {
                  for (var i = 0; i < datalenght; i++) {
                    print('ชื่อสินค้า : ${_orderdetail![i].product_name}');
                    print(
                        'จำนวนของสินค้า : ${_orderdetail![i].product_amount}');
                    _updateImport(
                      _orderdetail![i].product_name.toString(),
                      int.parse(_orderdetail![i].product_amount.toString()),
                    );
                  }
                  Art_Services().cancel_order(widget.order_id).then((value) {
                    Fluttertoast.showToast(
                        msg: "คืนของเข้าคลังเรียบร้อย",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 255, 0, 0),
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return admin_ordercancellist();
                    }));
                  });
                },
                label: Text("ยกเลิกออเดอร์"),
                icon: Icon(Icons.near_me),
                backgroundColor: Color(0xFFba181b),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('รายละเอียดการขาย'),
          backgroundColor: Color(0xFF231942),
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
                        Text('${widget.order_id}'),
                        SizedBox(height: 20),
                        Text(
                            'คนรับผิดชอบงาน :  ${widget.order_responsible_person}'),
                        SizedBox(height: 20),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _orderdetail != null
                              ? (_orderdetail?.length ?? 0)
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
                                        'ชื่อสินค้า : ${_orderdetail![index].product_name}'),
                                    Text(
                                        'จำนวน : ${_orderdetail![index].product_amount}'),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        'ราคาต่อชิ้น : ${_orderdetail![index].product_price}'),
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
                            Text('ราคารวม : ${widget.total_price}'),
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
