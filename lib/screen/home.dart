/*
import 'package:flutter/material.dart';
import 'package:project_bekery/screen/rider_home.dart';
import 'package:project_bekery/screen/user_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register/Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const user_HomeScreen();
                      }));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("เข้าใช้ในสถานะสมาชิก")),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const rider_HomeScreen();
                      }));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("เข้าใช้ในสถานะคนส่งของ")),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const rider_HomeScreen();
                      }));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("เข้าใช้ในสถานะผู้ดูแล")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
