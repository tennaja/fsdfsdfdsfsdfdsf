import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/rider_target_map.dart';

class rider_myorderdetail extends StatefulWidget {
  final String doc;
  const rider_myorderdetail(this.doc, {Key? key}) : super(key: key);

  @override
  State<rider_myorderdetail> createState() => _rider_myorderdetailState();
}

class _rider_myorderdetailState extends State<rider_myorderdetail> {
  Future<void> cancel_task(doc) async {
    final auth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('order');
    FirebaseFirestore.instance
        .collection('order')
        .get()
        .then((QuerySnapshot querySnapshot) {
      users.doc(doc).update(
        {
          'order_responsible_person': '',
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('order');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.doc).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text(widget.doc);
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
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return rider_target_map(
                              data['latitude'], data['longitude'], 'dfdf');
                        }));
                      },
                      label: Text("ดูแผนที่"),
                      icon: Icon(Icons.near_me),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: FloatingActionButton.extended(
                      heroTag: '2',
                      onPressed: () {
                        Art_Services()
                            .waitcancel_order(widget.doc, 'ยกเลิกโดยrider')
                            .then((value) => {
                                  Fluttertoast.showToast(
                                      msg: "ขอยกเลิกการสั่งเรียบร้อย",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 0, 0),
                                      textColor: Colors.white,
                                      fontSize: 16.0),
                                  Navigator.pop(context),
                                });

                        /*cancel_task(widget.doc).then((value) {
                          setState(() {});
                          Fluttertoast.showToast(
                              msg: "ยกเลิกงานรหัส : ${widget.doc}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color.fromARGB(255, 255, 1, 1),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pop(context);
                        });*/
                      },
                      label: Text("ยกเลิก"),
                      icon: Icon(Icons.near_me),
                    ),
                  ),
                ],
              ),
              appBar: AppBar(
                title: Text('รายละเอียดการสั่งซื้อ'),
                backgroundColor: Colors.blueAccent,
              ),
              backgroundColor: Colors.grey[100],
              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Container(
                        height: 600,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(data['order_id']),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                      'เวลา : ${DateFormat.yMMMd().add_jm().format(data['order_date'].toDate())}'),
                                ],
                              ),
                              SizedBox(height: 20),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: data != null
                                    ? (data["order_detail"]?.length ?? 0)
                                    : 0,
                                itemBuilder: (_, index) => Container(
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'ชื่อสินค้า : ${data['order_detail'][index]['product_name']}'),
                                          Text(
                                              'จำนวน : ${data['order_detail'][index]['product_quantity']}'),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              'ราคาต่อชิ้น : ${data['order_detail'][index]['product_price']}'),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('ราคารวม : ${data['total_price']}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ));
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('ใบเสร็จ'),
            backgroundColor: Colors.blueAccent,
          ),
        );
      },
    );
  }
}
