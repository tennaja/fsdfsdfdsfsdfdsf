// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_bekery/screen/rider_orderdetail.dart';

class rider_allorder extends StatefulWidget {
  const rider_allorder({Key? key}) : super(key: key);

  @override
  _rider_allorderState createState() => _rider_allorderState();
}

class _rider_allorderState extends State<rider_allorder> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('order')
      .where('order_responsible_person', isEqualTo: '')
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
                                return rider_orderdetail(
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
