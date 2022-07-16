// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/profile.dart';
import 'package:project_bekery/screen/home.dart';
import 'package:project_bekery/screen/user_welcome.dart';

class user_profile extends StatefulWidget {
  const user_profile({Key? key}) : super(key: key);

  @override
  _user_profileState createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  final auth = FirebaseAuth.instance;
  late Profile profile;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(auth.currentUser!.email).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('');
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text('');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: FloatingActionButton.extended(
                    heroTag: '1',
                    onPressed: () {},
                    label: Text("แก้ไข้ข้อมูล"),
                    icon: Icon(Icons.near_me),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 150,
                  child: FloatingActionButton.extended(
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
                    label: Text("ออกจากระบบ"),
                    icon: Icon(Icons.near_me),
                  ),
                ),
              ],
            ),
            appBar: AppBar(
              title: const Text('โปรไฟล์'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                              child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      label: Text(data['name']),
                                      hintText: 'ชื่อจริง',
                                      fillColor: Colors.white,
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'นามสกุล',
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
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
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (email) {},
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
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (phone) {},
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: 'โปรดใส่เบอร์โทร',
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
                            TextFormField(
                              obscureText: true,
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
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
                              maxLines: 1,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
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
          );
        }
        return Text("loading");
      },
    );
  }
}

Widget buildUserInfoDisplay(getValue, title, editPage) => Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 1,
        ),
        Container(
            width: 350,
            height: 40,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ))),
            child: Row(children: [
              Expanded(
                  child: TextButton(
                      onPressed: () {
                        editPage;
                      },
                      child: Text(
                        getValue,
                        style: TextStyle(fontSize: 16, height: 1.4),
                      ))),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 40.0,
              )
            ]))
      ],
    ));
