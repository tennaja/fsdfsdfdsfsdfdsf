import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/product_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/float_add_order.dart';

class admin_allproduct extends StatefulWidget {
  const admin_allproduct({Key? key}) : super(key: key);

  @override
  State<admin_allproduct> createState() => _admin_allproductState();
}

class _admin_allproductState extends State<admin_allproduct> {
  List<Product>? _product;

  @override
  void initState() {
    super.initState();
    _product = [];
    _getProduct('SELECT * from product');
  }

  _getProduct(sql) {
    print("function working");
    Services().getProduct(sql).then((product) {
      setState(() {
        _product = product;
      });
      print("Length ${product.length}");
      print(_product![0].product_name);
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
              child: Text(
            'รายชื่อสินค้าในคลัง',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return add_product_order();
                    }));
                  },
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.black,
                  ),
                  onSelected: (value) {
                    print('สถานะ : ${value.toString()}');
                    _getProduct(value);
                  },
                  itemBuilder: (BuildContext bc) {
                    return const [
                      PopupMenuItem(
                        child: Text("สินค้าใกล้หมด"),
                        value:
                            'SELECT * FROM `product` ORDER BY product_quantity ASC',
                      ),
                      PopupMenuItem(
                        child: Text("สินค้าขายดี"),
                        value:
                            'SELECT * FROM `product` ORDER BY export_product DESC',
                      ),
                    ];
                  },
                )
              ],
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
                itemCount: _product != null ? (_product?.length ?? 0) : 0,
                itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image(
                            image: NetworkImage(
                                _product![index].product_image.toString()),
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                              'ชื่อสินค้า : ${_product![index].product_name}'),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'ขายไป : ${_product![index].export_product}'),
                              Text(
                                  'เหลือในคลัง : ${_product![index].product_quantity}'),
                            ],
                          ),
                          tileColor: Colors.orangeAccent,
                          onTap: () {
                            product_update_detail(
                                _product![index].product_id.toString(),
                                _product![index].product_name.toString(),
                                _product![index].product_detail.toString(),
                                _product![index].product_price.toString(),
                                _product![index].product_quantity.toString(),
                                _product![index].export_product.toString(),
                                _product![index].import_product.toString());
                          },
                        ),
                      ),
                    )),
          ),
        ));
  }
}

class product_update_detail extends StatefulWidget {
  final String product_id,
      product_name,
      product_detail,
      product_price,
      product_quantity,
      export_product,
      import_product;
  const product_update_detail(
      this.product_id,
      this.product_name,
      this.product_detail,
      this.product_price,
      this.product_quantity,
      this.export_product,
      this.import_product,
      {Key? key})
      : super(key: key);

  @override
  State<product_update_detail> createState() => _product_update_detailState();
}

class _product_update_detailState extends State<product_update_detail> {
  final fromKey = GlobalKey<FormState>();
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
                /*
                
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
              */
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
                                      onSaved: (name) {},
                                      autofocus: false,
                                      initialValue: "",
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
                                      onSaved: (surname) {},
                                      autofocus: false,
                                      initialValue: "",
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
                                onSaved: (email) {},
                                autofocus: false,
                                initialValue: "",
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
                                onSaved: (phone) {},
                                autofocus: false,
                                initialValue: "",
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
