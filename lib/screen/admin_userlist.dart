// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/admin_welcome.dart';

class admin_Userlist extends StatefulWidget {
  const admin_Userlist({Key? key}) : super(key: key);

  @override
  State<admin_Userlist> createState() => _admin_UserlistState();
}

class _admin_UserlistState extends State<admin_Userlist> {
  List<User>? user;
  @override
  void initState() {
    super.initState();
    user = [];
    _getuserdata('customer');
  }

  _getuserdata(where) {
    Services().getUsers(where).then((datauser) => {
          setState(() {
            user = datauser;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
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
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(
                Icons.filter_alt_outlined,
                color: Colors.black,
              ),
              onSelected: (value) {
                print('สถานะ : ${value.toString()}');
                _getuserdata(value.toString());
              },
              itemBuilder: (BuildContext bc) {
                return const [
                  PopupMenuItem(
                    child: Text("แสดงข้อมูลลูกค้า"),
                    value: 'customer',
                  ),
                  PopupMenuItem(
                    child: Text("แสดงข้อมูลคนส่ง"),
                    value: 'rider',
                  )
                ];
              },
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.orangeAccent.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: user != null ? (user?.length ?? 0) : 0,
                itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          title: Text(
                              'ชื่อสมาชิก : ${user?[index].user_name}  ${user?[index].user_surname}'),
                          subtitle: Text('ตำแหน่ง : ${user?[index].user_role}'),
                          tileColor: Colors.orangeAccent,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return admin_userdetail(
                                  user?[index].user_id,
                                  user?[index].user_name,
                                  user?[index].user_surname,
                                  user?[index].user_phone,
                                  user?[index].user_email,
                                  user?[index].user_password,
                                  user?[index].user_latitude,
                                  user?[index].user_longitude,
                                  user?[index].user_role);
                            }));
                          },
                        ),
                      ),
                    )),
          ),
        ));
  }
}

class admin_userdetail extends StatefulWidget {
  final String? user_id,
      user_name,
      user_surname,
      user_phone,
      user_email,
      user_password,
      user_laitiude,
      user_longitude,
      user_role;

  const admin_userdetail(
      this.user_id,
      this.user_name,
      this.user_surname,
      this.user_phone,
      this.user_email,
      this.user_password,
      this.user_laitiude,
      this.user_longitude,
      this.user_role,
      {Key? key})
      : super(key: key);

  @override
  State<admin_userdetail> createState() => _admin_userdetailState();
}

class _admin_userdetailState extends State<admin_userdetail> {
  String dropdownValue = 'customer';
  final fromKey = GlobalKey<FormState>();
  String? username, usersurname, useremail, userrole, userphone;
  @override
  Widget build(BuildContext context) {
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
                      'ID : ${widget.user_id}\n Name : ${username}\n Surname : ${usersurname} \n Email : ${useremail}\n Role : ${dropdownValue}\n Phone : ${userphone}');
                  Services()
                      .update_user(widget.user_id, username, usersurname,
                          useremail, dropdownValue, userphone)
                      .then((value) => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return admin_WelcomeScreen();
                            })),
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
              },
              label: Text("แก้ไขข้อมูลผู้ใช้"),
              icon: Icon(Icons.settings),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 150,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              heroTag: '2',
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: Text("ลบข้อมูลผู้ใช้"),
              icon: Icon(Icons.delete),
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
            Navigator.of(context).pop();
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
                                      initialValue: "${widget.user_name}",
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
                                      initialValue: "${widget.user_surname}",
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
                                autofocus: false,
                                initialValue: "${widget.user_email}",
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
                                initialValue: "${widget.user_phone}",
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
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                    //background color of dropdown button
                                    border: Border.all(
                                        color: Colors.black38,
                                        width: 1), //border of dropdown button
                                    borderRadius: BorderRadius.circular(
                                        30), //border raiuds of dropdown button
                                  ),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                      child: DropdownButton(
                                        dropdownColor: Colors.orangeAccent,
                                        value: dropdownValue,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        // ignore: prefer_const_literals_to_create_immutables
                                        items: <String>[
                                          'customer',
                                          'rider',
                                          'admin'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        icon: Padding(
                                            //Icon at tail, arrow bottom is default icon
                                            padding: EdgeInsets.only(left: 20),
                                            child: Icon(Icons.arrow_downward)),
                                        iconEnabledColor: Color.fromARGB(
                                            255, 0, 0, 0), //Icon color

                                        //dropdown background color
                                        underline:
                                            Container(), //remove underline
                                        isExpanded:
                                            true, //make true to make width 100%
                                      )))
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
