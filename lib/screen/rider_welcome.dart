// ignore_for_file: unused_field, unused_import, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:project_bekery/screen/rider_allorder.dart';
import 'package:project_bekery/screen/rider_home.dart';
import 'package:project_bekery/screen/rider_login.dart';
import 'package:project_bekery/screen/rider_myorder.dart';
import 'package:project_bekery/screen/rider_profire.dart';
import 'package:project_bekery/screen/user_map.dart';
import 'package:project_bekery/screen/user_myorder.dart';
import 'package:project_bekery/screen/user_profire.dart';

import 'home.dart';

class rider_WelcomeScreen extends StatelessWidget {
  const rider_WelcomeScreen({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
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
                        CupertinoPageRoute(builder: (context) => LoginPage()),
                        (_) => false,
                      );
                    },
                    child: const Text("ใช่"),
                  ),
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: const MaterialApp(
        title: _title,
        home: MyStatefulWidget(),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: rider_allorder()), //หน้า1

    Center(child: user_MapsPage()), //หน้า2

    Center(child: rider_myorder()), //หน้า3

    Center(child: rider_profire()), //หน้า4
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'ร้านค้า',
            backgroundColor: Colors.orangeAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'แผนที่',
            backgroundColor: Colors.orangeAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'ประวัติการซื้อ',
            backgroundColor: Colors.orangeAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'โปรไฟล์',
            backgroundColor: Colors.orangeAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
