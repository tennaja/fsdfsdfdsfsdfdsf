import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/login/profire_model/customer_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_userlist.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';

import '../drawer/Constants/Constants.dart';

class adminaddrider extends StatefulWidget {
  const adminaddrider({Key? key}) : super(key: key);

  @override
  State<adminaddrider> createState() => _adminaddriderState();
}

_addEmployee(user_name, user_surname, user_phone, user_email, user_password) {
  Art_Services()
      .addrider(user_name, user_surname, user_phone, user_email, user_password);
}

class _adminaddriderState extends State<adminaddrider> {
  final fromKey = GlobalKey<FormState>();
  Customer customer = Customer(
      id: '', name: '', surname: '', phone: '', email: '', password: '');
  final TextEditingController _pass = TextEditingController();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");
  late String name, surname, email, password, val;

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> firebase = Firebase.initializeApp();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Container(
      color: Colors.pinkAccent.withOpacity(0.2),
      child: FutureBuilder(
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
                body: SliderDrawer(
                  appBar: SliderAppBar(
                    drawerIconColor: Colors.white,
                    appBarHeight: 85,
                    appBarColor: Color(0xFF5e548e),
                    title: Container(
                      child: Center(
                          child: const Text(
                        'เพิ่มข้อมูลพนักงาน',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  slider: ComplexDrawer(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colorz.complexDrawerBlack,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                                key: fromKey,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                          validator: RequiredValidator(
                                              errorText: "กรุณาป้อนข้อมูล"),
                                          onSaved: (name) {
                                            customer.name = name!;
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                            label : Text( 'ชื่อจริง', style: TextStyle(color: Colors.white),),
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                          validator: RequiredValidator(
                                              errorText: "กรุณาป้อนข้อมูล"),
                                          onSaved: (surname) {
                                            customer.surname = surname!;
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                            label : Text( 'นามสกุล', style: TextStyle(color: Colors.white),),
                                            prefixIcon: const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "โปรดใส่ข้อมูลด้วย"),
                                      EmailValidator(
                                          errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (email) {
                                      customer.email = email!;
                                    },
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                      label : Text( 'โปรดใส่อีเมลล์', style: TextStyle(color: Colors.white),),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (phone) {
                                      customer.phone = phone!;
                                    },
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                      label :Text ( 'โปรดใส่เบอร์โทร', style: TextStyle(color: Colors.white),),
                                      prefixIcon: const Icon(
                                        Icons.local_phone, 
                                        color: Colors.white,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                    controller: _pass,
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    obscureText: true,
                                    onSaved: (password) {
                                      customer.password = password!;
                                    },
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      label : Text( 'โปรดใส่พาสเวิร์ด', style: TextStyle(color: Colors.white),),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "โปรดใส่ข้อมูล";
                                      }
                                      if (val != _pass.text) {
                                        return "รหัสไม่ถูกต้อง";
                                      }
                                    },
                                    maxLines: 1,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      label : Text( 'ยืนยันพาสเวิร์ด', style: TextStyle(color: Colors.white),),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 340,
                                    height: 50,
                                     child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF5e548e),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        //////// HERE
                                      ),
                                      onPressed: () async {
                                        showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'เพิ่มข้อมูลพนักงาน'),
                                                content: const Text(
                                                    'ต้องการที่จะเพิ่มข้อมูลพนักงานไหม?'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text("ไม่"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      if (fromKey.currentState!
                                                          .validate()) {
                                                        fromKey.currentState!
                                                            .save();
                                                        Utils(context)
                                                            .startLoading();
                                                        print(customer.name);
                                                        print(customer.surname);
                                                        print(customer.email);
                                                        print(
                                                            customer.password);
                                                        print(customer.phone);
                                                        try {
                                                          Art_Services()
                                                              .getonlyRider(
                                                                  customer
                                                                      .email)
                                                              .then((value) {
                                                            print(
                                                                'USER ---> ${value.length}');
                                                            if (value
                                                                .isNotEmpty) {
                                                              Utils(context)
                                                                  .stopLoading();
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "มีผู้ใช้อีเมลนี้มีผู้ใช้แล้ว",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          0,
                                                                          0),
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            } else if (customer
                                                                    .password
                                                                    .length <=
                                                                5) {
                                                              Utils(context)
                                                                  .stopLoading();
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "รหัสผ่านสั้นเกินไป",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          0,
                                                                          0),
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            } else if (customer
                                                                    .phone
                                                                    .length !=
                                                                10) {
                                                              Utils(context)
                                                                  .stopLoading();
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "เบอร์โทรไม่ตรงตามแบบ",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          0,
                                                                          0),
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            } else {
                                                              _addEmployee(
                                                                  customer.name,
                                                                  customer
                                                                      .surname,
                                                                  customer
                                                                      .phone,
                                                                  customer
                                                                      .email,
                                                                  customer
                                                                      .password);
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "Register success",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return admin_Userlist();
                                                              }));
                                                            }
                                                          });
                                                        } on FirebaseAuthException catch (e) {
                                                          Utils(context)
                                                              .stopLoading();
                                                          print(e.code);
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "${e.message}",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0);
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      } else {
                                                        Utils(context)
                                                            .stopLoading();
                                                        Fluttertoast.showToast(
                                                            msg: "error",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.red,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text("ใช่"),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                     
                                      child: const Text(
                                        'เพิ่มข้อมูลพนักงาน',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ]))
                          ],
                        ),
                      ),
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
          }),
    );
  }
}
