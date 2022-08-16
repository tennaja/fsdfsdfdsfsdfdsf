// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/home.dart';
import 'package:project_bekery/screen/user_welcome.dart';

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
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          title: Center(
              child: const Text(
            'รายชื่อสมาชิก',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.orangeAccent.withOpacity(0.5),
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              heroTag: '1',
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
              label: Text("แก้ไขข้อมูลผู้ใช้"),
              icon: Icon(Icons.settings),
            ),
          ),
        ],
      ),
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
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
        title: Center(
            child: const Text(
          'รายชื่อสมาชิก',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.password_sharp,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.orangeAccent.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
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
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.black,
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
                                      onSaved: (surname) {
                                        usersurname = surname!;
                                      },
                                      autofocus: false,
                                      initialValue: "${user![0].user_surname}",
                                      decoration: InputDecoration(
                                        label: Text('นามสกุล'),
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.black,
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
                                enabled: false,
                                autofocus: false,
                                initialValue: "${user![0].user_email}",
                                decoration: InputDecoration(
                                  label: Text('อีเมล์'),
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
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
                                decoration: InputDecoration(
                                  label: Text('เบอร์โทรศัพท์'),
                                  prefixIcon: const Icon(
                                    Icons.local_phone,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
