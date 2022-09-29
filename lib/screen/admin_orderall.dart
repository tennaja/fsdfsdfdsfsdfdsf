import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';

class admin_orderall extends StatefulWidget {
  const admin_orderall({Key? key}) : super(key: key);

  @override
  State<admin_orderall> createState() => _admin_orderallState();
}

class _admin_orderallState extends State<admin_orderall> {
  List<Export_product>? _Export_product;
  List<Export_product_detail>? _orderdetail;
  late int datalength;
  List<String> datadetail_lengthlist = [];

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    _Export_product = [];
    _getImport_product('ยังไม่มีใครรับ');
    print(datadetail_lengthlist);
  }

  _getImport_product(where) async {
    print("function working");
    Art_Services().gatallExport_product(where).then((value) {
      setState(() {
        _Export_product = value;
        datalength = value.length;
      });
    });
  }

  _getquantity(order_id) {
    int? datadetail_length;
    print('--------------------------funtion--------------------------------');
    print('รับข้อมูล : ${order_id}');
    Art_Services().getorder_detail(order_id.toString()).then((value) {
      setState(() {
        datadetail_length = value.length;
      });
    });
    return datadetail_length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      appBar: SliderAppBar(
        trailing: PopupMenuButton(
          icon: Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
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
        ),
        appBarHeight: 85,
        appBarColor: Color(0xFF036666),
        title: Container(
          child: Center(
              child: const Text(
            'รายงานการขาย',
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
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:
                  _Export_product != null ? (_Export_product?.length ?? 0) : 0,
              itemBuilder: (_, index) => Center(
                    child: Card(
                      elevation: 20,
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: _Export_product![index].order_status ==
                                    'ยังไม่มีใครรับ'
                                ? Icon(
                                    Icons.timelapse,
                                    color: Color.fromARGB(255, 255, 166, 0),
                                  )
                                : _Export_product![index].order_status ==
                                        'ส่งเรียบร้อย'
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.lightGreen,
                                      )
                                    : _Export_product![index].order_status ==
                                            'รายการที่ยกเลิก'
                                        ? Icon(
                                            Icons.cancel,
                                            color:
                                                Color.fromARGB(255, 255, 0, 0),
                                          )
                                        : _Export_product![index]
                                                    .order_status ==
                                                'ของกำลังส่ง'
                                            ? Icon(
                                                Icons.motorcycle,
                                                color: Colors.lightGreen,
                                              )
                                            : Container(),
                            title: Text(
                                'รหัสการสั่ง : ${_Export_product![index].order_id}'),
                            subtitle: Text(
                                'จำนวนรายการ : ${_Export_product![index].product_amount}'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'วันที่สั่ง ${_Export_product![index].date}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              admin_oderall_detail(
                                                  _Export_product![index]
                                                      .order_id
                                                      .toString(),
                                                  _Export_product![index]
                                                      .total_price
                                                      .toString(),
                                                  _Export_product![index]
                                                      .order_responsible_person
                                                      .toString())));
                                },
                                child: const Text('รายละเอียด >'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
/*
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.orangeAccent,
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
                    ),*/
                  )),
        ),
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
    Art_Services().getorder_detail(widget.order_id).then((value) {
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
        centerTitle: true,
        title: Text('รายละเอียดการขาย'),
        backgroundColor: Color(0xFF036666),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: <Widget>[
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
                      _orderdetail != null ? (_orderdetail?.length ?? 0) : 0,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                      "${_orderdetail![index].product_amount} x"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${_orderdetail![index].product_name}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                '${_orderdetail![index].product_price}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ลด 20 %",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                '- 20',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /*
                Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("1 x"),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "ข้าวตราฉัตร",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            '250',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ลด 20 %",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            '- 20',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),*/
              ),
            ),
          ),
          Container(
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
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ราคา ",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "250",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 90,
            child: Card(
              elevation: 20,
              color: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ส่วนลด"),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ลด 20 % ",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          '- 20',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "รวม",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      Text(
                        '${widget.total_price} บาท',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),

      /*SingleChildScrollView(
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
        )*/
    );
  }
}
