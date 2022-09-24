import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/model/import_detail.dart';
import 'package:project_bekery/model/product_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/float_add_order.dart';
import 'package:project_bekery/script/firebaseapi.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project_bekery/widgets/adminAppbar.dart';
import 'package:table_calendar/table_calendar.dart';

class admin_report extends StatefulWidget {
  const admin_report({Key? key}) : super(key: key);

  @override
  State<admin_report> createState() => _admin_reportState();
}

class _admin_reportState extends State<admin_report> {
  List<Product>? _product;
  DateTime selectedDate = DateTime.now();
  List<Export_product_detail>? _Import_product;
  int? datalength;

  @override
  void initState() {
    super.initState();
    _getImport_product(DateFormat('yyyy-MM-d').format(selectedDate));
    _Import_product = [];
  }

  _getImport_product(selectedDate) {
    print("function working");
    Art_Services()
        .getorderonly_detail(selectedDate.toString())
        .then((Import_detail) {
      setState(() {
        _Import_product = Import_detail;
        datalength = Import_detail.length;
      });

      print('จำนวข้อมูล : ${Import_detail.length}');
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _getImport_product(DateFormat('yyyy-MM-d').format(selectedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
            appBar: SliderAppBar(
              trailing: IconButton(
                icon: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                onPressed: () {
                  _selectDate(context);
                },
              ),
              appBarHeight: 85,
              appBarColor: const Color(0xFF358f80),
              title: Container(
                child: const Center(
                    child: Text(
                  'รายงานยอดการขาย',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            slider: const ComplexDrawer(),
            child: _Import_product?.length != 0
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 30),
                          child: Center(
                              child: Text(
                                  'รายงานวันที่ : ${DateFormat('วันที่ d เดือน MMMM ปี y', 'th').format(DateTime.parse('${selectedDate}'))}')),
                        ),
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: DataTable(
                              columns: [
                                DataColumn(label: Text('ชื่อสินค้า')),
                                DataColumn(label: Text('ขายได้')),
                              ],
                              rows: _Import_product!
                                  .map(
                                    (importorder) => DataRow(cells: [
                                      DataCell(Text(
                                          importorder.product_name.toString())),
                                      DataCell(Text(
                                          importorder.sum_quantity.toString())),
                                    ]),
                                  )
                                  .toList()),
                        )),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text('ราคารวม : '),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.orangeAccent.withOpacity(0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                            'https://cdn.iconscout.com/icon/free/png-256/data-not-found-1965034-1662569.png'),
                        const SizedBox(),
                        Text(
                            'ไม่มีการขายในวันที่ ${DateFormat('yyyy-MM-d').format(selectedDate)}'),
                      ],
                    ),
                  )));
  }
}
