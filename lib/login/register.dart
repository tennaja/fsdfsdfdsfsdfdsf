import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:project_bekery/login/profire_model/customer_model.dart';
import 'package:project_bekery/mysql/service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

_addEmployee(user_name, user_surname, user_phone, user_email, user_password) {
  Art_Services()
      .addUser(user_name, user_surname, user_phone, user_email, user_password);
}

class _RegisterPageState extends State<RegisterPage> {
  final fromKey = GlobalKey<FormState>();
  Customer customer = Customer(
      id: '', name: '', surname: '', phone: '', email: '', password: '');
  final TextEditingController _pass = TextEditingController();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");
  late String name, surname, email, password, val;

  @override
  Widget build(BuildContext context) {
    /*Future<void> connect(BuildContext ctx) async {
      debugPrint("Connecting...");
      try {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("LOADING"),
              content: CircularProgressIndicator(),
            );
          },
        );
        await SqlConn.connect(
            ip: "119.59.97.4",
            port: "2222",
            databaseName: "web5_project",
            username: "web5_project",
            password: "OKv7fzyC");
        debugPrint("Connected!");
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        Navigator.pop(context);
      }
    }

    Future<void> read(String query) async {
      var res = await SqlConn.readData(query);
      debugPrint(res.toString());
    }

    Future<void> write(String query) async {
      var res = await SqlConn.writeData(query);
      debugPrint(res.toString());
    }
*/
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
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'ลงทะเบียน',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.blue),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Form(
                              key: fromKey,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        validator: RequiredValidator(
                                            errorText: "กรุณาป้อนข้อมูล"),
                                        onSaved: (name) {
                                          customer.name = name!;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'ชื่อจริง',
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.blue,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black),
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
                                        validator: RequiredValidator(
                                            errorText: "กรุณาป้อนข้อมูล"),
                                        onSaved: (surname) {
                                          customer.surname = surname!;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'นามสกุล',
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: Colors.blue,
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
                                    hintText: 'โปรดใส่อีเมลล์',
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.blue,
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
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (phone) {
                                    customer.phone = phone!;
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'โปรดใส่เบอร์โทร',
                                    prefixIcon: const Icon(
                                      Icons.local_phone,
                                      color: Colors.blue,
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
                                  controller: _pass,
                                  validator: RequiredValidator(
                                      errorText: "กรุณาป้อนข้อมูล"),
                                  obscureText: true,
                                  onSaved: (password) {
                                    customer.password = password!;
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.blue,
                                    ),
                                    hintText: 'โปรดใส่พาสเวิร์ด',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
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
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.blue,
                                    ),
                                    hintText: 'ยืนยันพาสเวิร์ด',
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
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      print(customer.name);
                                      print(customer.surname);
                                      print(customer.email);
                                      print(customer.password);
                                      if (fromKey.currentState!.validate()) {
                                        fromKey.currentState!.save();
                                        // ignore: avoid_print
                                        try {
                                          Art_Services()
                                              .getonlyUser(customer.email)
                                              .then((value) {
                                            print('USER ---> ${value.length}');
                                            if (value.isNotEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "มีผู้ใช้อีเมลนี้มีผู้ใช้แล้ว",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (customer.password.length <=
                                                5) {
                                              Fluttertoast.showToast(
                                                  msg: "รหัสผ่านสั้นเกินไป",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else if (customer.phone.length !=
                                                10) {
                                              Fluttertoast.showToast(
                                                  msg: "เบอร์โทรไม่ตรงตามแบบ",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              _addEmployee(
                                                  customer.name,
                                                  customer.surname,
                                                  customer.phone,
                                                  customer.email,
                                                  customer.password);

                                              Fluttertoast.showToast(
                                                  msg: "Register success",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              Navigator.pop(context);
                                            }
                                          });

                                          /*
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: customer.email,
                                                  password: customer.password)
                                              .then((result) {
                                           
                                           
                                          final FirebaseAuth auth =
                                              FirebaseAuth.instance;
                                          var list = [];
                                          _usersCollection
                                              .doc("${customer.email}")
                                              .set({
                                            "id": customer.id,
                                            "name": customer.name,
                                            "surname": customer.surname,
                                            "email": customer.email,
                                            "password": customer.password,
                                            "Role": "customer",
                                            "u_latitude": '',
                                            "u_longitude": '',
                                            "user_cart":
                                                FieldValue.arrayUnion(list),
                                          }).then((value) {
                                            fromKey.currentState!.reset();
                                            Fluttertoast.showToast(
                                                msg: "Register success",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            Navigator.pop(context);
                                          });*/

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
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "error",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    },
                                  style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(30.0),
      ),
      side: BorderSide(width: 2, color: Colors.blue),
   ),
                                    child: const Text(
                                      'ลงทะเบียน',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('มีอีเมลล์อยู่แล้วใช่ไหม ?'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                          'ถ้ามีคลิกที่นี่เพื่อเข้าสู่ระบบ'),
                                    ),
                                  ],
                                ),
                              ]))
                        ],
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
