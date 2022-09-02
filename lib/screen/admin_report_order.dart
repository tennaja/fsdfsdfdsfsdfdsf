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

  @override
  void initState() {
    super.initState();
    _getImport_product(DateFormat('yyyy-MM-d').format(selectedDate));
  }

  DateTime selectedDate = DateTime.now();
  List<Export_product_detail>? _Import_product;
  int? datalength;

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
          icon: Icon(
            Icons.calendar_month,
            color: Colors.black,
          ),
          onPressed: () {
            _selectDate(context);
          },
        ),
        appBarHeight: 85,
        appBarColor: Color.fromARGB(255, 255, 222, 178),
        title: Container(
          child: Center(
              child: const Text(
            'รายงานยอดการขาย',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
        ),
      ),
      slider: AdminAppBar(),
      child: _Import_product?.length != 0
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.orangeAccent.withOpacity(0.5),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _Import_product != null
                      ? (_Import_product?.length ?? 0)
                      : 0,
                  itemBuilder: (_, index) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.orangeAccent,
                            child: ListTile(
                              leading: Image(
                                image: NetworkImage(_Import_product![index]
                                    .product_image
                                    .toString()),
                                width: 50,
                                height: 50,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              title: Text(_Import_product![index]
                                  .product_name
                                  .toString()),
                              subtitle: Text(
                                  'จำนวนที่ขายได้ : ${_Import_product![index].sum_quantity.toString()} ชิ้น'),
                              tileColor: Colors.orangeAccent,
                            ),
                          ),
                        ),
                      )),
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
                  SizedBox(),
                  Text(
                      'ไม่มีการขายในวันที่ ${DateFormat('yyyy-MM-d').format(selectedDate)}'),
                ],
              ),
            ),
    ));
  }
}
