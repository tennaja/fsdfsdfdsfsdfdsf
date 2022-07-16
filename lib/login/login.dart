import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/login/profire_model/customer_model.dart';
import 'package:project_bekery/login/register.dart';
import 'package:project_bekery/screen/rider_welcome.dart';
import 'package:project_bekery/screen/user_welcome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final fromKey = GlobalKey<FormState>();
  late String email;
  late String password;
  Customer customer = Customer(
      id: '', name: '', surname: '', phone: '', email: '', password: '');
  @override

  /*
  
  */
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.pinkAccent.withOpacity(0.2),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.fitWidth),
              ),
              width: 500,
              height: 325,
              child: SizedBox(
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    width: 100,
                    height: 100,
                    scale: 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 50),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Form(
                          key: fromKey,
                          child: Column(children: [
                            TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "โปรดใส่ข้อมูลด้วย"),
                                EmailValidator(
                                    errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                              ]),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'โปรดใส่อีเมลล์',
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onSaved: (email) {
                                customer.email = email!;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "กรุณาป้อนข้อมูล"),
                              maxLines: 1,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'โปรดใส่พาสเวิร์ด',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onSaved: (password) {
                                customer.password = password!;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 340,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (fromKey.currentState!.validate()) {
                                    fromKey.currentState!.save();
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(customer.email)
                                        .get()
                                        .then((DocumentSnapshot
                                            documentSnapshot) {
                                      try {
                                        if (documentSnapshot.exists) {
                                          print('documentSnapshot.exists');
                                          if (documentSnapshot.get("Role") ==
                                              "customer") {
                                            print('Role = Customer');
                                            try {
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: customer.email,
                                                      password:
                                                          customer.password)
                                                  .then((value) {
                                                try {
                                                  Fluttertoast.showToast(
                                                      msg: "Login success",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.green,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    // ignore: prefer_const_constructors
                                                    return const user_WelcomeScreen();
                                                  }));
                                                } on PlatformException catch (e) {
                                                  print(
                                                      "---------------ERROR-----------------");
                                                  Fluttertoast.showToast(
                                                      msg: "${e.message}",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                }
                                              });
                                              // ignore: empty_catches, unused_catch_clause, nullable_type_in_catch_clause
                                            } on PlatformException catch (e) {
                                              print(e.code);
                                              Fluttertoast.showToast(
                                                  msg: "${e.message}",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          } else if (documentSnapshot
                                                  .get("Role") ==
                                              "admin") {
                                            print('Role = Admin');
                                            try {
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: customer.email,
                                                      password:
                                                          customer.password)
                                                  .then((value) {
                                                Fluttertoast.showToast(
                                                    msg: "Login success",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.green,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  // ignore: prefer_const_constructors
                                                  return const user_WelcomeScreen();
                                                }));
                                              });
                                              // ignore: empty_catches, unused_catch_clause, nullable_type_in_catch_clause
                                            } on PlatformException catch (e) {
                                              print(e.code);
                                              Fluttertoast.showToast(
                                                  msg: "${e.message}",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          } else if (documentSnapshot
                                                  .get("Role") ==
                                              "rider") {
                                            print('Role = Rider');
                                            try {
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email: customer.email,
                                                      password:
                                                          customer.password)
                                                  .then((value) {
                                                Fluttertoast.showToast(
                                                    msg: "Login success",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.green,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  // ignore: prefer_const_constructors
                                                  return const rider_WelcomeScreen();
                                                }));
                                              });
                                              // ignore: empty_catches, unused_catch_clause, nullable_type_in_catch_clause
                                            } on PlatformException catch (e) {
                                              print(e.code);
                                              Fluttertoast.showToast(
                                                  msg: "${e.message}",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "สิทธ์ในการเข้าถึงไม่ถูกต้อง",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        } else if (documentSnapshot.exists) {
                                          Fluttertoast.showToast(
                                              msg: "ไม่มีข้อมูลผู้ใช้ในระบบ",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      } on PlatformException catch (e) {
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
                                    });
                                    //if (check == true) {
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "ไม่มีข้อมูลผู้ใช้ในระบบ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.pinkAccent.withOpacity(0.8)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            side: BorderSide(
                                                color: Colors.pinkAccent)))),
                                child: const Text(
                                  'เข้าสู่ระบบ',
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
                                const Text('มีบัญชีแล้วหรือไม่ ?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()),
                                    );
                                  },
                                  child: const Text(
                                      'ถ้ายังคลิกที่นี่เพื่อเข้าสู่ระบบ'),
                                ),
                              ],
                            ),
                          ])),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
