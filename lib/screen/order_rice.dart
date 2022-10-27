// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bekery/screen/productdetail.dart';

class order_rice extends StatefulWidget {
  order_rice(String product_type);

  @override
  _order_riceState createState() => _order_riceState();
}

class _order_riceState extends State<order_rice> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('product').snapshots();

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

        return ListView(
          scrollDirection: Axis.horizontal,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.only(left: 2, right: 2, top: 2),
              height: 225,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                  ),
                  Center(
                    child: Image.network(
                      data['product_image'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            data['product_name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child:
                                  Text('฿ ${data['product_price'].toString()}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                '${data['product_price'].toString()} ขายแล้ว',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 60, top: 5),
                              child: Container(
                                  height: 30,
                                  width: 145,
                                  child: OutlinedButton(
                                      child: Row(
                                        children: const [
                                          Text(
                                            "รายละเอียดสินค้า",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Icon(
                                            Icons.manage_search,
                                            size: 10,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return productdetail(
                                            data['product_id'].toString(),
                                          );
                                        }));
                                      })),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
