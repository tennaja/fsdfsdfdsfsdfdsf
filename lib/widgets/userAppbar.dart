import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/user_changepassword.dart';
import 'package:project_bekery/screen/user_logstatus.dart';
import 'package:project_bekery/screen/user_map.dart';
import 'package:project_bekery/screen/user_mymaps.dart';
import 'package:project_bekery/screen/user_myorder.dart';
import 'package:project_bekery/screen/user_order.dart';
import 'package:project_bekery/screen/user_profire.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';

class UserAppBar extends StatefulWidget {
  const UserAppBar({Key? key}) : super(key: key);

  @override
  State<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  String? user_email, user_id;
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
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                accountName: user?.length != 0
                    ? Text('${user?[0].user_name}',style: TextStyle(color: Colors.black),)
                    : Text('Loadding...'),
                accountEmail: user?.length != 0
                    ? Text('${user?[0].user_email}',style: TextStyle(color: Colors.black),)
                    : Text('Loadding...'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 36.0,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'ร้านค้า',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 15,) ,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Orderpage();
                  }));
                },
              ),
              Divider(
                
              ),
              ListTile(
                title: Text(
                  'แผนที่',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.map,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 15,) ,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_MapsPage();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'แผนที่ของฉัน',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.maps_home_work,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 15,) ,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_mymapspage();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'ประวัติการซื้อขาย',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.history,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 15,) ,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_order();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'โปรไฟล์',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 15,) ,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_profile();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'เปลี่ยนรหัส',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.key,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 15,) ,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_changepassword();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'ประวัติการเข้าใช้งาน',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.work_history_outlined,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 15,) ,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return user_logstatus();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'ออกจากระบบ',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 15,) ,
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
                              onPressed: () async {
                                Utils(context).startLoading();
                                await Art_Services().adduserlog(
                                    'ล็อคเอาท์',
                                    user?[0].user_id,
                                    DateTime.now().toString());
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
