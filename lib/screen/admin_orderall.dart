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
    _getImport_product();
  }

  _getImport_product() {
    print("function working");
    Services().gatallExport_product().then((value) {
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
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.content_paste_sharp,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    _getImport_product();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {},
                )
              ],
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
                          title: Text(
                              'ราคารวม : ${_Export_product![index].total_price.toString()}'),
                          subtitle: Text(
                              'ที่มา : ${_Export_product![index].order_by.toString()}'),
                          tileColor: Colors.orangeAccent,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return admin_oderall_detail(
                                  _Export_product![index].order_by.toString(),
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
  final String order_by, total_price, order_responsible_person;
  const admin_oderall_detail(
      this.order_by, this.total_price, this.order_responsible_person,
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
    Services().getorder_detail().then((value) {
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
                        Text('${widget.order_by}'),
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
