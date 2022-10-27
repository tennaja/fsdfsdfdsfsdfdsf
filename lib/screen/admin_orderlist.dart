import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/mysql/rider.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';

class admin_orderlist extends StatefulWidget {
  const admin_orderlist({Key? key}) : super(key: key);

  @override
  State<admin_orderlist> createState() => _admin_orderlistState();
}

class _admin_orderlistState extends State<admin_orderlist> {
  List<Export_product>? _Export_product;
  List<Export_product>? _filterImport_product;
  List<int> datalength = [];
  int? datadetaillength = 0;
  List<User>? user = [];

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    _Export_product = [];
    _getImport_product('รอการยืนยันจาก Admin');
  }

  _getImport_product(where) async {
    print("function working");
    await Art_Services().gatallExport_product(where).then((value) {
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
          title: Text('ยืนยันรับออเดอร์'),
        ),
        drawer: /*AdminAppBar(),*/
            ComplexDrawer(),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: datadetaillength == 0
                ? Container(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/correct_image.png',
                        height: 100,
                        width: 100,
                      ),
                      Text('รับงานทั้งหมดเรียบร้อยแล้ว',
                          style: TextStyle(
                            color: Colors.black,
                          ))
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
                                child: Column(children: [
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    title: Text(
                                        'วันที่สั่ง : ${DateFormat('วันที่ d เดือน MMMM ปี y', 'th').format(DateTime.parse('${_Export_product![index].date}'))}'),
                                    subtitle: Text(
                                        'ที่มา : ${_Export_product![index].order_by}'),
                                    tileColor: Colors.yellow,
                                    onTap: () {
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
                                              .toString(),
                                        );
                                      }));
                                    },
                                  ),
                                ]),
                              ),
                            ),
                          )),
                        ))));
  }
}

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
  List<Rider>? rider = [];
  @override
  void initState() {
    super.initState();
    _orderdetail = [];
    _getImport_product();
  }

  _getImport_product() async {
    print("function working");
    await Art_Services().getorder_detail(widget.order_id).then((value) {
      setState(() {
        _orderdetail = value;
      });
    });
    await Art_Services().getonlyRider(_orderdetail![0].order_by).then((value) {
      setState(() {
        rider = value;
      });
      print('จำนวข้อมูล : ${value.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                heroTag: 1,
                onPressed: () async {
                  Art_Services().accept_order(widget.order_id).then((value) => {
                        Fluttertoast.showToast(
                            msg: "จัดส่งเรียบร้อย",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 0, 255, 30),
                            textColor: Colors.white,
                            fontSize: 16.0),
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return admin_orderlist();
                        }))
                      });
                },
                label: Text("รับออเดอร์"),
                icon: Icon(Icons.near_me),
                backgroundColor: Colors.green,
              ),
              FloatingActionButton.extended(
                heroTag: 2,
                onPressed: () async {
                  showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('ยกเลิกออเดอร์'),
                          content: const Text('ต้องการที่จะยกเลิกออเดอร์ไหม?'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("ไม่"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                Utils(context).startLoading();
                                await Art_Services()
                                    .cancel_order(widget.order_id)
                                    .then((value) => {
                                          Fluttertoast.showToast(
                                              msg: "ยกเลิกการสั่งเรียบร้อย",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 0, 0),
                                              textColor: Colors.white,
                                              fontSize: 16.0),
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return admin_orderlist();
                                          }))
                                        });
                              },
                              child: const Text("ใช่"),
                            ),
                          ],
                        );
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
