// ignore_for_file: avoid_print, duplicate_ignore, unnecessary_brace_in_string_interps, unused_import, unnecessary_string_interpolations, unused_local_variable, unused_field, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:project_bekery/screen/rider_home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
// ignore: import_of_legacy_library_into_null_safe

class rider_RegisterScreen extends StatefulWidget {
  const rider_RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<rider_RegisterScreen> {
  final fromKey = GlobalKey<FormState>();
  Profile profile = Profile(
      id: '',
      email: '',
      username: '',
      password: '',
      Role: '',
      u_latitude: '',
      u_longitude: '');
  late String email;
  late String password;
  late String username;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
            ),
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("สร้างบัญชีผู้ใช้"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("username", style: TextStyle(fontSize: 20)),
                    TextFormField(
                      validator:
                          RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
                      onSaved: (username) {
                        profile.username = username!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
                      validator:
                          RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
                      obscureText: true,
                      onSaved: (password) {
                        profile.password = password!;
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text("ลงทะเบียน"),
                        onPressed: () async {
                          if (fromKey.currentState!.validate()) {
                            fromKey.currentState!.save();

                            // ignore: avoid_print
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: profile.email,
                                      password: profile.password)
                                  .then((result) {
                                profile.id = result.user!.uid;
                              });
                              _usersCollection.doc("${profile.email}").set({
                                "id": profile.id,
                                "name": profile.username,
                                "email": profile.email,
                                "password": profile.password,
                                "Role": profile.Role = "rider",
                                "u_latitude": profile.u_latitude,
                                "u_longitude": profile.u_longitude,
                              }).then((value) {
                                fromKey.currentState!.reset();
                                print(
                                    " fullname = ${profile.username} \n email = ${profile.email} \n password = ${profile.password}");
                                Fluttertoast.showToast(
                                    msg: "Register success",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const rider_HomeScreen();
                                }));
                              });
                              // ignore: empty_catches, unused_catch_clause
                            } on FirebaseAuthException catch (e) {
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
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
