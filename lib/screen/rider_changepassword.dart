import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/mysql/rider.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/rider_profire.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';
import 'package:project_bekery/widgets/riderAppbar.dart';
import 'package:project_bekery/widgets/userAppbar.dart';

class rider_changepassword extends StatefulWidget {
  const rider_changepassword({Key? key}) : super(key: key);

  @override
  State<rider_changepassword> createState() => _user_changepasswordState();
}

class _user_changepasswordState extends State<rider_changepassword> {
  final fromKey = GlobalKey<FormState>();
  String? user_email, password1, password2, originpassword;
  final TextEditingController _pass = TextEditingController();
  List<Rider>? user = [];
  void initState() {
    super.initState();
    _getuserdata();
  }

  _getuserdata() async {
    user_email = await SessionManager().get("email");
    Art_Services().getonlyRider(user_email.toString()).then((datauser) => {
          setState(() {
            user = datauser;
          }),
        });
  }

  _changepassword(password) async {
    user_email = await SessionManager().get("email");
    await Art_Services()
        .changeriderpassword(user_email.toString(), password.toString())
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "เปลี่ยนรหัสเรียบร้อย",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color.fromARGB(255, 0, 255, 47),
                  textColor: Colors.white,
                  fontSize: 16.0),
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return rider_profire();
              })),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.blue,
          appBarHeight: 85,
          appBarColor: Colors.white,
          title: Container(
            child: Center(
                child: const Text(
              'แก้ไข้หรัสผ่าน',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        slider: RiderAppBar(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 238, 238, 238),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                                key: fromKey,
                                child: Column(children: [
                                  TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "โปรดใส่ข้อมูล";
                                      }
                                      if (val != _pass.text) {
                                        return "รหัสไม่ถูกต้อง";
                                      }
                                    },
                                    onSaved: (originpassword1) {
                                      setState(() {
                                        originpassword = originpassword1;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      label: Text('รหัสเดิม'),
                                      prefixIcon: const Icon(
                                        Icons.key,
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
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "โปรดใส่ข้อมูล";
                                      }
                                      if (val != _pass.text) {
                                        return "รหัสไม่ถูกต้อง";
                                      }
                                    },
                                    onSaved: (password) {
                                      setState(() {
                                        password1 = password;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      label: Text('ใส่รหัสผ่านใหม่'),
                                      prefixIcon: const Icon(
                                        Icons.key,
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
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "โปรดใส่ข้อมูล";
                                      }
                                      if (val != _pass.text) {
                                        return "รหัสไม่ถูกต้อง";
                                      }
                                    },
                                    onSaved: (password) {
                                      setState(() {
                                        password2 = password;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      label: Text('ยืนยันรหัสผ่าน'),
                                      prefixIcon: const Icon(
                                        Icons.key,
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
                                  Container(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('แก้ไขรหัสผ่าน'),
                                                content: const Text(
                                                    'ต้องการแก้ไขรหัสผ่านใช้ไหม?'),
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
                                                        Utils(context)
                                                            .startLoading();
                                                        user_email =
                                                            await SessionManager()
                                                                .get("email");
                                                        fromKey.currentState!
                                                            .save();
                                                        print(user_email);
                                                        print(originpassword);
                                                        Art_Services()
                                                            .Loginrider(
                                                                user_email,
                                                                originpassword)
                                                            .then((value) {
                                                          if (value.isEmpty) {
                                                            Utils(context)
                                                                .stopLoading();
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "รหัสเดิมไม่ถูกต้อง",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          } else if (password1 !=
                                                              password2) {
                                                            Utils(context)
                                                                .stopLoading();
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "รหัสไม่เหมือนกัน",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          } else {
                                                            _changepassword(
                                                                password1);
                                                          }
                                                        });
                                                      } else {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text("ใช่"),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Text('เปลี่ยนรหัส'),
                                    ),
                                  )
                                ]))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
