// ignore_for_file: unused_import

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/export_product.dart';
import 'package:project_bekery/model/export_product_detail.dart';
import 'package:project_bekery/model/userlog.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/user_myorderdetail.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';
import 'package:project_bekery/widgets/userAppbar.dart';
import 'package:http/http.dart' as http;

import '../mysql/user.dart';

class user_logstatus extends StatefulWidget {
  const user_logstatus({Key? key}) : super(key: key);

  @override
  _user_orderState createState() => _user_orderState();
}

class _user_orderState extends State<user_logstatus> {
  String title = 'รายการของฉัน';
  List<User>? user;
  List<Logstatus>? log;
  String? user_email, email;

  void initState() {
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    super.initState();
    user = [];
    log = [];
    _getonlyuser();
  }

  _getonlyuser() async {
    user_email = await SessionManager().get("email");
    await Art_Services().getonlyUser(user_email).then((value) {
      setState(() {
        user = value;
      });
    });
    await Art_Services().getuserlog(user![0].user_id).then((value) {
      setState(() {
        log = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.blue,
          appBarHeight: 85,
          appBarColor: Colors.white,
          title: Container(
            child: Center(
                child: Text(
              'ประวัติการเข้าใช้งาน',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        slider: UserAppBar(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 238, 238, 238),
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: log != null ? (log?.length ?? 0) : 0,
            itemBuilder: (_, index) => Container(
              child: ListTile(
                leading: log![index].log_status == 'ล็อคอิน'
                    ? Icon(Icons.login,color: Colors.blue,)
                    : Icon(Icons.logout,color: Colors.blue,),
                title: Text(
                    '${DateFormat('วันที่ d MMMM y เวลา HH : MM', 'th').format(DateTime.parse('${log![index].log_date}'))}'),
                subtitle: Text(log![index].log_status),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
