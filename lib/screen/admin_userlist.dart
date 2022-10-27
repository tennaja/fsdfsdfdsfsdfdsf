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
import 'package:project_bekery/mysql/rider.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';

class admin_Userlist extends StatefulWidget {
  const admin_Userlist({Key? key}) : super(key: key);

  @override
  State<admin_Userlist> createState() => _admin_UserlistState();
}

class _admin_UserlistState extends State<admin_Userlist> {
  List<User>? user;
  List<Rider>? rider;
  String status = 'customer';
  @override
  void initState() {
    _getuserdata('customer');
    super.initState();
  }

  _getuserdata(where) {
    Art_Services().getUsers(where).then((datauser) => {
          setState(() {
            user = datauser;
          }),
        });
  }

  _getriderdata() {
    Art_Services().getallRider().then((datauser) => {
          setState(() {
            rider = datauser;
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
                  setState(() {
                    status = value.toString();
                  });
                  print('สถานะ : ${status}');
                  if (value == 'customer') {
                    _getuserdata('customer');
                  } else {
                    _getriderdata();
                  }
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
                    child: status == 'customer'
                        ? ListView.builder(
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
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        title: Text(
                                            'ชื่อสมาชิก : ${user?[index].user_name}  ${user?[index].user_surname}'),
                                        subtitle: Text(
                                            'ตำแหน่ง : ${user?[index].user_role}'),
                                        tileColor: Colors.yellow,
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
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
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: rider != null ? (rider?.length ?? 0) : 0,
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
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        title: Text(
                                            'ชื่อสมาชิก : ${rider?[index].rider_name}  ${rider?[index].rider_surname}'),
                                        subtitle: Text(
                                            'ตำแหน่ง : ${rider?[index].rider_role}'),
                                        tileColor: Colors.yellow,
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return admin_riderdetail(
                                                rider?[index].rider_id,
                                                rider?[index].rider_name,
                                                rider?[index].rider_surname,
                                                rider?[index].rider_phone,
                                                rider?[index].rider_email,
                                                rider?[index].rider_password,
                                                rider?[index].rider_latitude,
                                                rider?[index].rider_longitude,
                                                rider?[index].rider_role);
                                          }));
                                        },
                                      ),
                                    ]),
                                  ),
                                ),
                              )),
                            ),
                          )))));
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
                            onPressed: () async {
                              Utils(context).startLoading();
                              if (fromKey.currentState!.validate()) {
                                fromKey.currentState!.save();
                                print(
                                    'ID : ${widget.user_id}\n Name : ${username}\n Surname : ${usersurname} \n Email : ${useremail}\n Role : ${dropdownValue}\n Phone : ${userphone}');
                                Art_Services()
                                    .update_user(
                                        widget.user_id,
                                        username,
                                        usersurname,
                                        useremail,
                                        dropdownValue,
                                        userphone)
                                    .then((value) => {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return admin_Userlist();
                                          })),
                                          Fluttertoast.showToast(
                                              msg: "แก้ไขข้อมูลเรียบร้อย",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Color.fromARGB(
                                                  255, 9, 255, 0),
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
                            child: const Text("ใช่"),
                          ),
                        ],
                      );
                    });
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
                            onPressed: () async {
                              Utils(context).startLoading();
                              await Art_Services()
                                  .deleteUser(widget.user_id.toString());
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_Userlist();
                              }));
                            },
                            child: const Text("ใช่"),
                          ),
                        ],
                      );
                    });
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
                                enabled: false,
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

class admin_riderdetail extends StatefulWidget {
  final String? user_id,
      user_name,
      user_surname,
      user_phone,
      user_email,
      user_password,
      user_laitiude,
      user_longitude,
      user_role;

  const admin_riderdetail(
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
  State<admin_riderdetail> createState() => _admin_riderdetailState();
}

class _admin_riderdetailState extends State<admin_riderdetail> {
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
              onPressed: () async {
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
                            onPressed: () async {
                              if (fromKey.currentState!.validate()) {
                                Utils(context).startLoading();
                                fromKey.currentState!.save();
                                await Art_Services().update_rider(
                                    widget.user_id,
                                    username,
                                    usersurname,
                                    widget.user_email,
                                    widget.user_role,
                                    userphone);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return admin_Userlist();
                                }));
                                Fluttertoast.showToast(
                                    msg: "แก้ไขข้อมูลเรียบร้อย",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Color.fromARGB(255, 9, 255, 0),
                                    textColor: Colors.white,
                                    fontSize: 16.0);

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
                            child: const Text("ใช่"),
                          ),
                        ],
                      );
                    });
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
                                enabled: false,
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
