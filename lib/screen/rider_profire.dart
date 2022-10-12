// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:project_bekery/mysql/rider.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/rider.dart';
import 'package:project_bekery/screen/home.dart';
import 'package:project_bekery/screen/user_welcome.dart';
import 'package:project_bekery/widgets/riderAppbar.dart';
import 'package:project_bekery/widgets/userAppbar.dart';

class rider_profire extends StatefulWidget {
  const rider_profire({Key? key}) : super(key: key);

  @override
  _user_profileState createState() => _user_profileState();
}

class _user_profileState extends State<rider_profire> {
  final fromKey = GlobalKey<FormState>();
  String? username, usersurname, useremail, userrole, userphone, user_email;
  List<Rider>? rider = [];
  void initState() {
    super.initState();
    _getuserdata();
  }

  _getuserdata() async {
    user_email = await SessionManager().get("email");
    Art_Services().getonlyRider(user_email.toString()).then((datauser) => {
          setState(() {
            rider = datauser;
          }),
        });
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    if (rider?.length == 0) {
      return Scaffold(
        body: SliderDrawer(
          appBar: SliderAppBar(
            drawerIconColor: Colors.blue,
            trailing: IconButton(
              onPressed: () {
                if (fromKey.currentState!.validate()) {
                  fromKey.currentState!.save();
                  print(
                      'ID : ${rider![0].rider_id}\n Name : ${rider![0].rider_name}\n Surname : ${rider![0].rider_surname} \n Email : ${rider![0].rider_email}\n Phone : ${rider![0].rider_phone}');
                  Art_Services()
                      .update_rider(rider![0].rider_id, username, usersurname,
                          useremail, 'rider', userphone)
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
              icon: Icon(
                Icons.save,
                color: Colors.blue,
              ),
            ),
            appBarHeight: 85,
            appBarColor: Colors.white,
            title: Container(
              child: Center(
                  child: const Text(
                'แก้ไขโปรไฟล์',
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
          ),
        ),
      );
    }
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.blue,
          appBarHeight: 85,
          appBarColor: Colors.white,
          title: Container(
            child: Center(
                child: const Text(
              'แก้ไขโปรไฟล์',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      initialValue: "${rider![0].rider_name}",
                                      decoration: InputDecoration(
                                        labelText: 'ชื่อจริง',
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.blue,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue),
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
                                      initialValue:
                                          "${rider![0].rider_surname}",
                                      decoration: InputDecoration(
                                        label: Text('นามสกุล'),
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
                                onSaved: (email) {
                                  useremail = email!;
                                },
                                enabled: false,
                                autofocus: false,
                                initialValue: "${rider![0].rider_email}",
                                decoration: InputDecoration(
                                  label: Text('อีเมล์'),
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
                                onSaved: (phone) {
                                  userphone = phone!;
                                },
                                autofocus: false,
                                initialValue: "${rider![0].rider_phone}",
                                decoration: InputDecoration(
                                  label: Text('เบอร์โทรศัพท์'),
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
                                readOnly: true,
                                initialValue: "${rider![0].rider_password}",
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.key,
                                      color: Colors.blue,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    labelText: 'รหัสผ่าน',
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
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                      onPressed: () {
                        if (fromKey.currentState!.validate()) {
                          fromKey.currentState!.save();
                          print(
                              'ID : ${rider![0].rider_id}\n Name : ${rider![0].rider_name}\n Surname : ${rider![0].rider_surname} \n Email : ${rider![0].rider_email}\n Phone : ${rider![0].rider_phone}');
                          Art_Services()
                              .update_rider(rider![0].rider_id, username,
                                  usersurname, useremail, 'rider', userphone)
                              .then((value) => {
                                    Fluttertoast.showToast(
                                        msg: "แก้ไขข้อมูลเรียบร้อย",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            Color.fromARGB(255, 9, 255, 0),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => rider_profire()));
                      },
                      child: Text('บันทึกข้อมูล'),
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
