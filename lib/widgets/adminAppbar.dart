import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/mysql/rider.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/addproducttype.dart';
import 'package:project_bekery/screen/addpromotion.dart';
import 'package:project_bekery/screen/admin_addproduct_promotion.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/screen/admin_import_product.dart';
import 'package:project_bekery/screen/admin_orderall.dart';
import 'package:project_bekery/screen/admin_orderlist.dart';
import 'package:project_bekery/screen/admin_productall.dart';
import 'package:project_bekery/screen/admin_report_order.dart';
import 'package:project_bekery/screen/admin_userlist.dart';
import 'package:project_bekery/screen/float_add_order.dart';
import 'package:project_bekery/screen/rider_allorder.dart';
import 'package:project_bekery/screen/rider_changepassword.dart';
import 'package:project_bekery/screen/rider_myorder.dart';
import 'package:project_bekery/screen/rider_profire.dart';

class AdminAppBar extends StatefulWidget {
  const AdminAppBar({Key? key}) : super(key: key);

  @override
  State<AdminAppBar> createState() => _AdminAppBarState();
}

class _AdminAppBarState extends State<AdminAppBar> {
  String? user_email;
  List<Rider>? rider = [];
  void initState() {
    _getuserdata();
    super.initState();
  }

  _getuserdata() async {
    user_email = await SessionManager().get("email");
    Art_Services().getonlyRider(user_email.toString()).then((datauser) => {
          setState(() {
            rider = datauser;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                ),
                accountName: rider?.length != 0
                    ? Text('${rider?[0].rider_name}')
                    : Text('Loadding...'),
                accountEmail: rider?.length != 0
                    ? Text('${rider?[0].rider_email}')
                    : Text('Loadding...'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 163, 92, 0),
                  child: Icon(
                    Icons.admin_panel_settings,
                    color: Colors.orangeAccent,
                    size: 36.0,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('หน้ารับออเดอร์'),
                leading: Icon(Icons.list),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return admin_orderlist();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('รายการนำเข้า'),
                leading: Icon(Icons.add_box),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return admin_import_order();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('นำเข้าสินค้า'),
                leading: Icon(Icons.shopping_basket),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return admin_import_source();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('ประวัติการนำเข้า'),
                leading: Icon(Icons.history_edu),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return adminhistoryimport();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('รายงานการขาย'),
                leading: Icon(Icons.assignment_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return admin_orderall();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('รายงานการยอดการขาย'),
                leading: Icon(Icons.bar_chart),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return admin_report();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('รายชื่อผู้ใช้'),
                leading: Icon(Icons.account_box),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return admin_Userlist();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('รายงานสินค้าในคลัง'),
                leading: Icon(Icons.production_quantity_limits),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return admin_allproduct();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('เพิ่มประเภทสินค้า'),
                leading: Icon(Icons.add_box),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return addproducttype();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('เพิ่มโปรโมชั่น'),
                leading: Icon(Icons.money),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return addpromotion();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('เพิ่มสินค้า'),
                leading: Icon(Icons.add),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return add_product_order();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('เพิ่มโปรโมชั่นให้สินค้า'),
                leading: Icon(Icons.money_sharp),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return admin_addproductpromotion();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('ออกจากระบบ'),
                leading: Icon(Icons.logout),
                onTap: () {
                  showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('ออกจากระบบ'),
                          content: const Text('ต้องการที่จะออกจากระบบไหม?'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("ไม่"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) => LoginPage()),
                                  (_) => false,
                                );
                              },
                              child: const Text("ใช่"),
                            ),
                          ],
                        );
                      });
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
