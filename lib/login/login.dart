import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/login/profire_model/customer_model.dart';
import 'package:project_bekery/login/register.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/screen/rider_allorder.dart';
import 'package:project_bekery/screen/rider_welcome.dart';
import 'package:project_bekery/screen/user_myorder.dart';
import 'package:project_bekery/screen/user_order.dart';
import 'package:project_bekery/screen/user_welcome.dart';
import 'package:project_bekery/screen/admin_orderlist.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool UserSelected = true;
  late bool RiderSelected = false;
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
               
                width: 500,
                height: 325,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70),
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
              ),
              Container(
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
                                  color: Colors.blue,
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
                                prefixIcon: const Icon(Icons.lock,color: Colors.blue,),
                                hintText: 'โปรดใส่พาสเวิร์ด',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onSaved: (password) {
                                customer.password = password!;
                              },
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        RiderSelected = false;

                                        UserSelected = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 20,
                                            width: 20,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        153, 0, 0, 0))),
                                            child: UserSelected
                                                ? Container(
                                                    margin: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromARGB(
                                                            153, 0, 0, 0)),
                                                  )
                                                : SizedBox()),
                                        Text('Customer',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    153, 0, 0, 0),
                                                fontSize: 14.5))
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        UserSelected = false;

                                        RiderSelected = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 20,
                                            width: 20,
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        153, 0, 0, 0))),
                                            child: RiderSelected
                                                ? Container(
                                                    margin: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromARGB(
                                                            153, 0, 0, 0)),
                                                  )
                                                : SizedBox()),
                                        Text('Staff',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    153, 0, 0, 0),
                                                fontSize: 14.5))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: 340,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (fromKey.currentState!.validate()) {
                                    fromKey.currentState!.save();
                                    if (UserSelected == true) {
                                      print('เข้าใช้ในถานะUser');
                                      print('${customer.email}');
                                      Art_Services()
                                          .Loginuser(
                                              customer.email, customer.password)
                                          .then((value) async => {
                                                print(value.length),
                                                if (value.isNotEmpty)
                                                  {
                                                    await SessionManager().set(
                                                        "email",
                                                        '${customer.email}'),
                                                    print(value[0].user_role),
                                                    print(
                                                        'Sesion : ${await SessionManager().get("email")}'),
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return Orderpage();
                                                    })),
                                                  }
                                                else
                                                  {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "ไม่มีข้อมูลผู้ใช้ในระบบของUser",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0),
                                                  }
                                              });
                                    } else {
                                      print('เข้าใช้ในถานะStaff');
                                      print('${customer.email}');
                                      Art_Services()
                                          .Loginrider(
                                              customer.email, customer.password)
                                          .then((value) async => {
                                                print(value.length),
                                                if (value.isNotEmpty)
                                                  {
                                                    await SessionManager().set(
                                                        "email",
                                                        '${customer.email}'),
                                                    print(value[0].rider_role),
                                                    print(
                                                        'Sesion : ${await SessionManager().get("email")}'),
                                                    if (value[0].rider_role ==
                                                        'rider')
                                                      {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return rider_allorder();
                                                        })),
                                                      }
                                                    else if (value[0]
                                                            .rider_role ==
                                                        'admin')
                                                      {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return admin_orderlist();
                                                        })),
                                                      }
                                                  }
                                                else
                                                  {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "ไม่มีข้อมูลผู้ใช้ในระบบของStaff",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0),
                                                  }
                                              });
                                    }
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

                                  /*
      
      
                                print(SessionManager()
                                                          .get("email")),
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return rider_WelcomeScreen();
                                                      })),
                                                    
                                                  
                                                      print(SessionManager()
                                                          .get("email")),
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return admin_WelcomeScreen();
                                                      })),
      
      
                                  */
                                },
                                 style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(30.0),
      ),
      side: BorderSide(width: 2, color: Colors.blue),
   ),
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
            ],
          ),
        ),
      ),
    );
  }
}
