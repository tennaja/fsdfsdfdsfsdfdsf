import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/mysql/rider.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/rider_allorder.dart';
import 'package:project_bekery/screen/rider_changepassword.dart';
import 'package:project_bekery/screen/rider_myorder.dart';
import 'package:project_bekery/screen/rider_profire.dart';

class RiderAppBar extends StatefulWidget {
  const RiderAppBar({Key? key}) : super(key: key);

  @override
  State<RiderAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<RiderAppBar> {
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
                    Icons.motorcycle,
                    color: Colors.orangeAccent,
                    size: 36.0,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('รายการสั่งซื้อ'),
                leading: Icon(Icons.assignment_late),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_allorder();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('แผนที่'),
                leading: Icon(Icons.map),
                onTap: () {
                  /*
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_MapsPage();
                  }));*/
                },
              ),
              Divider(),
              ListTile(
                title: Text('รายการงานของฉัน'),
                leading: Icon(Icons.assignment_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_myorder();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('ประวัติงานของฉัน'),
                leading: Icon(Icons.history),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_history();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('โปรไฟล์'),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_profire();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('เปลี่ยนรหัส'),
                leading: Icon(Icons.key),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_changepassword();
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
