import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class rider_orderdetail extends StatefulWidget {
  final String doc;
  const rider_orderdetail(this.doc, {Key? key}) : super(key: key);

  @override
  State<rider_orderdetail> createState() => _rider_orderdetailState();
}

class _rider_orderdetailState extends State<rider_orderdetail> {
  Future<void> accept_task(doc) async {
    final auth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('order');
    FirebaseFirestore.instance
        .collection('order')
        .get()
        .then((QuerySnapshot querySnapshot) {
      users.doc(doc).update(
        {
          'order_responsible_person': auth.currentUser!.email,
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
              floatingActionButton: Container(
                width: 250,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    print(widget.doc);
                    accept_task(widget.doc).then((value) {
                      setState(() {});
                      Fluttertoast.showToast(
                          msg: "รับงานรหัส : ${widget.doc}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 56, 255, 1),
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pop(context);
                    });
                  },
                  label: Text("ยืนยันการส่ง"),
                  icon: Icon(Icons.near_me),
                ),
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
