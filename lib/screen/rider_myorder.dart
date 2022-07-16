// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bekery/screen/rider_myorderdetail.dart';
import 'package:project_bekery/screen/rider_orderdetail.dart';

class rider_myorder extends StatefulWidget {
  const rider_myorder({Key? key}) : super(key: key);

  @override
  _rider_myorderState createState() => _rider_myorderState();
}

class _rider_myorderState extends State<rider_myorder> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('order')
      .where('order_responsible_person',
          isEqualTo: FirebaseAuth.instance.currentUser!.email)
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
            title: Text("รายการงานของฉัน"),
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
                                return rider_myorderdetail(
                                    data['order_id'].toString());
                              }));
                            },
                            title: Text(
                                'เวลา : ${DateFormat.yMMMd().add_jm().format(data['order_date'].toDate())}'),
                            subtitle: Text(
                                'ราคา : ${data['total_price'].toString()}'),
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
