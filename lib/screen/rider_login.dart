// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names, avoid_print, duplicate_ignore, avoid_web_libraries_in_flutter

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/screen/rider_welcome.dart';

import 'user_home.dart';
import 'user_welcome.dart';

class rider_LoginScreen extends StatefulWidget {
  const rider_LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<rider_LoginScreen> {
  final fromKey = GlobalKey<FormState>();
  Profile profile = Profile(
      id: '',
      email: '',
      username: '',
      password: '',
      Role: '',
      u_latitude: '',
      u_longitude: '');
  late String email = "asd";
  late String password;
  late String username;
  late bool check = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Loading"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {}
        return Scaffold(
          appBar: AppBar(
            title: const Text("เข้าสู่ระบบ"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("อีเมล", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "โปรดใส่ข้อมูลด้วย"),
                      EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                    ]),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (email) {
                      profile.email = email!;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                  TextFormField(
                    validator: RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
                    obscureText: true,
                    onSaved: (password) {
                      profile.password = password!;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: const Text("เข้าส่ระบบ"),
                        onPressed: () {
                          if (fromKey.currentState!.validate()) {
                            fromKey.currentState!.save();
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(profile.email)
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                print(
                                    'Document data: ${documentSnapshot.get("Role")}');
                                if (documentSnapshot.get("Role") == "rider") {
                                  check = true;
                                  print("check = true");
                                  try {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      Fluttertoast.showToast(
                                          msg: "Login success",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        // ignore: prefer_const_constructors
                                        return const rider_WelcomeScreen();
                                      }));
                                    });
                                    // ignore: empty_catches, unused_catch_clause, nullable_type_in_catch_clause
                                  } on FirebaseAuthException catch (e) {
                                    // ignore: avoid_print
                                    print(e.code);
                                    Fluttertoast.showToast(
                                        msg: "${e.message}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "สิทธ์ในการเข้าถึงไม่ถูกต้อง",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                print(
                                    'Document does not exist on the database');
                              }
                            });
                            //if (check == true) {
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
