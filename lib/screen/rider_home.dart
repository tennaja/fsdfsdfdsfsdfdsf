// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:project_bekery/screen/rider_login.dart';
import 'package:project_bekery/screen/rider_register.dart';

class rider_HomeScreen extends StatelessWidget {
  const rider_HomeScreen({Key? key}) : super(key: key);
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
              Image.asset("assets/images/logo.png"),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const rider_RegisterScreen();
                      }));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("สมัครสมาชิก")),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const rider_LoginScreen();
                      }));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("เข้าส่ระบบ")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
