import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/user_changepassword.dart';
import 'package:project_bekery/screen/user_map.dart';
import 'package:project_bekery/screen/user_myorder.dart';
import 'package:project_bekery/screen/user_order.dart';
import 'package:project_bekery/screen/user_profire.dart';

class UserAppBar extends StatefulWidget {
  const UserAppBar({Key? key}) : super(key: key);

  @override
  State<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  String? user_email;
  List<User>? user = [];
  void initState() {
    super.initState();
    _getuserdata();
  }

  _getuserdata() async {
    user_email = await SessionManager().get("email");
    Art_Services().getonlyUser(user_email.toString()).then((datauser) => {
          setState(() {
            user = datauser;
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
                accountName: user?.length != 0
                    ? Text('${user?[0].user_name}')
                    : Text('Loadding...'),
                accountEmail: user?.length != 0
                    ? Text('${user?[0].user_email}')
                    : Text('Loadding...'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 163, 92, 0),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.orangeAccent,
                    size: 36.0,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('ร้านค้า'),
                leading: Icon(Icons.shopping_bag),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Orderpage();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('แผนที่'),
                leading: Icon(Icons.map),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_MapsPage();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('ประวัติการซื้อขาย'),
                leading: Icon(Icons.history),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_order();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('โปรไฟล์'),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_profile();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('เปลี่ยนรหัส'),
                leading: Icon(Icons.key),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_changepassword();
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
