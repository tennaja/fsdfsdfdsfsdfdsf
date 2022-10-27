// ignore_for_file: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/screen/admin_import_product.dart';
import 'package:project_bekery/screen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' show Platform;

import 'login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // Replace with actual values
      /*options: const FirebaseOptions(
      apiKey: "AIzaSyAj4GhdAQFlNLhNLv5DpvR6vCDUiaxFBWM",
      appId: "1:139664672802:web:1f61439e6d98a839d1a27b",
      messagingSenderId: "139664672802",
      projectId: "bakery203",
    ),*/
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage());
  }
}
