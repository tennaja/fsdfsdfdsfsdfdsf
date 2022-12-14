import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/mysql/rider.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/rider_allorder.dart';
import 'package:project_bekery/screen/rider_changepassword.dart';
import 'package:project_bekery/screen/rider_map.dart';
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
                accountName: rider?.length != 0
                    ? Text(
                        '${rider?[0].rider_name}',
                        style: TextStyle(color: Colors.black),
                      )
                    : Text(
                        'Loadding...',
                        style: TextStyle(color: Colors.black),
                      ),
                accountEmail: rider?.length != 0
                    ? Text(
                        '${rider?[0].rider_email}',
                        style: TextStyle(color: Colors.black),
                      )
                    : Text(
                        'Loadding...',
                        style: TextStyle(color: Colors.black),
                      ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.motorcycle,
                    color: Colors.white,
                    size: 36.0,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('??????????????????????????????????????????'),
                leading: Icon(
                  Icons.assignment_late,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_allorder();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('?????????????????????????????????????????????'),
                leading: Icon(
                  Icons.assignment_outlined,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_myorder();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('????????????????????????????????????????????????'),
                leading: Icon(
                  Icons.history,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_history();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('?????????????????????'),
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_profire();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('?????????????????????????????????'),
                leading: Icon(
                  Icons.key,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return rider_changepassword();
                  }));
                },
              ),
              Divider(),
              ListTile(
                title: Text('??????????????????????????????'),
                leading: Icon(
                  Icons.logout,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('??????????????????????????????'),
                          content: const Text('????????????????????????????????????????????????????????????????????????????'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("?????????"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                      builder: (context) => LoginPage()),
                                  (_) => false,
                                );
                              },
                              child: const Text("?????????"),
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
