import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/import_detail.dart';
import 'package:project_bekery/model/import_product.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_product.dart';
import 'package:project_bekery/screen/admin_welcome.dart';
import 'package:project_bekery/screen/float_add_order.dart';
import 'package:http/http.dart' as http;

class admin_report_data extends StatefulWidget {
  const admin_report_data({Key? key}) : super(key: key);

  @override
  State<admin_report_data> createState() => _admin_report_dataState();
}

class _admin_report_dataState extends State<admin_report_data> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.orangeAccent.withOpacity(0.5),
      ),
    );
  }
}
