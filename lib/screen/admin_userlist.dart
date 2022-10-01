// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';

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
    Art_Services().getUsers(where).then((datauser) => {
          setState(() {
            user = datauser;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
            appBar: SliderAppBar(
              drawerIconColor: Colors.white,
              trailing: PopupMenuButton(
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
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
              ),
              appBarHeight: 85,
              appBarColor: Color(0xFFe0b1cb),
              title: Container(
                child: Center(
                    child: const Text(
                  'รายชื่อผู้ใช้',
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
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: user != null ? (user?.length ?? 0) : 0,
                    itemBuilder: (_, index) => Center(
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 8.0),
                        child: Container(
                          child: Card(
                            elevation: 20,
                            color: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                title: Text(
                                    'ชื่อสมาชิก : ${user?[index].user_name}  ${user?[index].user_surname}'),
                                subtitle:
                                    Text('ตำแหน่ง : ${user?[index].user_role}'),
                                tileColor: Colors.yellow,
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
                            ]),
                          ),
                        ),
                      )),
                    ),
                  ),
                ))));
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
    setState(() {
      dropdownValue = widget.user_role.toString();
    });
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
                  Art_Services()
                      .update_user(widget.user_id, username, usersurname,
                          useremail, dropdownValue, userphone)
                      .then((value) => {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return admin_Userlist();
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
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFFe0b1cb),
        elevation: 0,
        title: Center(
            child: const Text(
          'รายชื่อสมาชิก',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        )),
        actions: <Widget>[],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colorz.complexDrawerBlack,
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
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                        ),
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
                                      onSaved: (surname) {
                                        usersurname = surname!;
                                      },
                                      autofocus: false,
                                      initialValue: "${widget.user_surname}",
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          borderSide: const BorderSide(
                                              color: Colors.white),
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
                                initialValue: "${widget.user_email}",
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
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
                                initialValue: "${widget.user_phone}",
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
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
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                    //background color of dropdown button
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 1), //border of dropdown button
                                    borderRadius: BorderRadius.circular(
                                        30), //border raiuds of dropdown button
                                  ),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                      child: DropdownButton(
                                        dropdownColor:
                                            Colorz.complexDrawerBlack,
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
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }).toList(),
                                        icon: Padding(
                                            //Icon at tail, arrow bottom is default icon
                                            padding: EdgeInsets.only(left: 20),
                                            child: Icon(Icons.arrow_downward)),
                                        iconEnabledColor:
                                            Colors.white, //Icon color

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
