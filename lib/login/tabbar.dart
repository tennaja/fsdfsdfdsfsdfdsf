import 'package:flutter/material.dart';
import 'package:project_bekery/login/register.dart';
import 'package:project_bekery/login/test.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({Key? key}) : super(key: key);

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: TabBarView(
            children: [
              RegisterPage(),
              TestPage(),
              Text('Doktong'),
              Text('Doktong'),
            ],
          ),
          bottomNavigationBar: TabBar(tabs: [
            Tab(
                icon: Icon(
              Icons.home_sharp,
              color: Colors.white,
            )),
            Tab(
                icon: Icon(
              Icons.list_alt_rounded,
              color: Colors.white,
            )),
            Tab(
                icon: Icon(
              Icons.notifications,
              color: Colors.white,
            )),
            Tab(
                icon: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            )),
          ]),
        ));
  }
}
