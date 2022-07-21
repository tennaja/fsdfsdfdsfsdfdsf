// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bekery/screen/user_myorderdetail.dart';

class user_order extends StatefulWidget {
  const user_order({Key? key}) : super(key: key);

  @override
  _user_orderState createState() => _user_orderState();
}

class _user_orderState extends State<user_order> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('order')
      .where('order_by', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("รายการสินค้า"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Container(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Card(
                          elevation: 6,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return user_myorderdetail(
                                    data['order_id'].toString());
                              }));
                            },
                            title: Text(
                                'เวลา : ${DateFormat.yMMMd().add_jm().format(data['order_date'].toDate())}'),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'ราคา : ${data['total_price'].toString()}'),
                                Text(
                                    'สถานะ : ${data['order_status'].toString()}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
