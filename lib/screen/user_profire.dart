// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/home.dart';
import 'package:project_bekery/screen/user_welcome.dart';
import 'package:project_bekery/widgets/userAppbar.dart';

class user_profile extends StatefulWidget {
  const user_profile({Key? key}) : super(key: key);

  @override
  _user_profileState createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  final fromKey = GlobalKey<FormState>();
  String? username, usersurname, useremail, userrole, userphone, user_email;
  List<User>? user = [];
  void initState() {
    super.initState();
    _getuserdata();
  }

  _getuserdata() async {
    user_email = await SessionManager().get("email");
    Art_Services().getonlyUser(user_email.toString()).then((datauser) => {
          setState(() {
            user = datauser;
          }),
        });
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    if (user?.length == 0) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('ออกจากระบบ'),
                      content: const Text('ต้องการที่จะออกจากระบบไหม?'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("ไม่"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                  builder: (context) => LoginPage()),
                              (_) => false,
                            );
                          },
                          child: const Text("ใช่"),
                        ),
                      ],
                    );
                  });
            },
          ),
          backgroundColor: Colors.greenAccent,
          elevation: 0,
          title: Center(
              child: const Text(
            'แก้ไขโปรไฟล์',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colorz.complexDrawerBlack,
        ),
      );
    }
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          trailing: IconButton(
            onPressed: () {
              if (fromKey.currentState!.validate()) {
                fromKey.currentState!.save();
                print(
                    'ID : ${user![0].user_id}\n Name : ${user![0].user_name}\n Surname : ${user![0].user_surname} \n Email : ${user![0].user_email}\n Phone : ${user![0].user_phone}');
                Art_Services()
                    .update_user(user![0].user_id, username, usersurname,
                        useremail, 'customer', userphone)
                    .then((value) => {
                          Fluttertoast.showToast(
                              msg: "แก้ไขข้อมูลเรียบร้อย",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color.fromARGB(255, 9, 255, 0),
                              textColor: Colors.white,
                              fontSize: 16.0),
                        });
                // ignore: avoid_print
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
              setState(() {});
            },
            icon: Icon(Icons.save),
          ),
          appBarHeight: 85,
          appBarColor: Colors.greenAccent,
          title: Container(
            child: Center(
                child: const Text(
              'แก้ไขโปรไฟล์',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        slider: UserAppBar(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colorz.complexDrawerBlack,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
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
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      onSaved: (name) {
                                        username = name!;
                                      },
                                      autofocus: false,
                                      initialValue: "${user![0].user_name}",
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        fillColor: Colors.white,
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
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onSaved: (surname) {
                                        usersurname = surname!;
                                      },
                                      autofocus: false,
                                      initialValue: "${user![0].user_surname}",
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        label: Text(
                                          'นามสกุล',
                                          style: TextStyle(color: Colors.white),
                                        ),
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
                                onSaved: (email) {
                                  useremail = email!;
                                },
                                autofocus: false,
                                initialValue: "${user![0].user_email}",
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  label: Text(
                                    'อีเมล์',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
                                onSaved: (phone) {
                                  userphone = phone!;
                                },
                                autofocus: false,
                                initialValue: "${user![0].user_phone}",
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  label: Text(
                                    'เบอร์โทรศัพท์',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
                                readOnly: true,
                                initialValue: "${user![0].user_password}",
                                style: TextStyle(color: Colors.white),
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.key,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    label: Text(
                                      "รหัสผ่าน",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    // this button is used to toggle the password visibility
                                    suffixIcon: IconButton(
                                        icon: Icon(_isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        })),
                              ),
                            ]))
                      ],
                    ),
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
