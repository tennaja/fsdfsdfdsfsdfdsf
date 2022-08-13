import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/mysql/service.dart';

class admin_orderall extends StatefulWidget {
  const admin_orderall({Key? key}) : super(key: key);

  @override
  State<admin_orderall> createState() => _admin_orderallState();
}

class _admin_orderallState extends State<admin_orderall> {
  List<Export_product>? _Export_product;
  List<Export_product>? _filterImport_product;

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    _Export_product = [];
    _getImport_product('ยังไม่มีใครรับ');
  }

  _getImport_product(where) {
    print("function working");
    Services().gatallExport_product(where).then((value) {
      setState(() {
        _Export_product = value;

        _filterImport_product = value;
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
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          title: Center(
              child: const Text(
            'ประวัติการซื้อขาย',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
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
                  ),
                  PopupMenuItem(
                    child: Text("ของกำลังส่ง"),
                    value: 'ของกำลังส่ง',
                  )
                ];
              },
            )
          ],
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
                itemCount: _Export_product != null
                    ? (_Export_product?.length ?? 0)
                    : 0,
                itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          title: Text(
                              'ราคารวม : ${_Export_product![index].total_price.toString()}'),
                          subtitle: Text(
                              'ที่มา : ${_Export_product![index].order_by.toString()}'),
                          tileColor: Colors.orangeAccent,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return admin_oderall_detail(
                                  _Export_product![index].order_id.toString(),
                                  _Export_product![index]
                                      .total_price
                                      .toString(),
                                  _Export_product![index]
                                      .order_responsible_person
                                      .toString());
                            }));
                          },
                        ),
                      ),
                    )),
          ),
        ));
  }
}

class admin_oderall_detail extends StatefulWidget {
  final String order_id, total_price, order_responsible_person;
  const admin_oderall_detail(
      this.order_id, this.total_price, this.order_responsible_person,
      {Key? key})
      : super(key: key);

  @override
  State<admin_oderall_detail> createState() => _admin_oderall_detailState();
}

class _admin_oderall_detailState extends State<admin_oderall_detail> {
  List<Export_product_detail>? _orderdetail;
  @override
  void initState() {
    super.initState();
    _orderdetail = [];
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Services().getorder_detail(widget.order_id).then((value) {
      setState(() {
        _orderdetail = value;
      });

      print('จำนวข้อมูล : ${value.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดการขาย'),
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
