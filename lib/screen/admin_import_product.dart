import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/model/adminbasket.dart';
import 'package:project_bekery/model/product_model.dart';
import 'package:project_bekery/screen/quantity.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';
import 'package:project_bekery/widgets/app_column.dart';
import 'package:project_bekery/widgets/app_icon.dart';
import 'package:project_bekery/widgets/big_text.dart';
import 'package:project_bekery/widgets/colors.dart';
import 'package:project_bekery/widgets/exandable_text_widget.dart';
import 'package:uuid/uuid.dart';

import '../login/login.dart';
import '../model/source_model.dart';
import '../mysql/service.dart';

class admin_import_source extends StatefulWidget {
  const admin_import_source({Key? key}) : super(key: key);

  @override
  State<admin_import_source> createState() => _admin_import_sourceState();
}

class _admin_import_sourceState extends State<admin_import_source> {
  List<source>? _source;
  List<source>? _filtersource;

  @override
  void initState() {
    super.initState();
    _source = [];
    _getsource();
  }

  _getsource() {
    print("function working");
    Art_Services().getSource().then((source) {
      print(
          "------------------------------------------------------------------------");
      setState(() {
        _source = source;

        _filtersource = source;
      });
      print("Length ${source.length}");
      print(_source![0].source_name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      appBar: SliderAppBar(
        appBarHeight: 85,
        appBarColor: Color(0xFFff8500),
        title: Container(
          child: Center(
              child: const Text(
            'นำเข้าสินค้า',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ),
        ),
      ),
      slider: ComplexDrawer(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _filtersource != null ? (_filtersource?.length ?? 0) : 0,
            itemBuilder: (_, index) => Center(
                 child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 8.0),
                        child: Container(
                  child:  Card(
                      elevation: 20,
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                        child: Column(
                          children: [ ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            title: Text(_source![index].source_name.toString(),
                                    style: TextStyle(
                                        color: Colors.black),),
                            subtitle: Text(
                                'รหัสแหล่งที่มา : ${_source![index].source_id.toString()}',
                                    style: TextStyle(
                                        color: Colors.black),),
                            tileColor: Colors.yellow,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return import_product_menu(
                                    _source![index].source_id,
                                    _source![index].source_name);
                              }));
                            },
                          ),
                        ]),
                      ),//*
                    ),
                  ),
                )),
      ))));
    
  }
}

class import_product_menu extends StatefulWidget {
  final source_id;
  final source_name;
  const import_product_menu(this.source_id, this.source_name, {Key? key})
      : super(key: key);

  @override
  State<import_product_menu> createState() => _import_product_menuState();
}

class _import_product_menuState extends State<import_product_menu> {
  List<Product>? _product;
  List<Product>? _filterproduct;

  @override
  void initState() {
    super.initState();
    _product = [];
    _getProduct();
  }

  _getProduct() {
    print("function working");
    Art_Services().getProduct('SELECT * from product').then((product) {
      setState(() {
        _product = product;

        _filterproduct = product;
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
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFFff8500),
        elevation: 0,
        title: Center(
            child: Text(
          '${widget.source_name.toString()}',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Admincraftimprotproduct(widget.source_id);
              }));
              // do somethingNavigator.push(context,
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: GridView.builder(
          itemCount: _filterproduct != null ? (_filterproduct?.length ?? 0) : 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.79),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: import_prodeuc_menu(
              widget.source_id.toString(),
              _filterproduct![index].product_id.toString(),
              _filterproduct![index].product_name.toString(),
              _filterproduct![index].product_detail.toString(),
              _filterproduct![index].product_image.toString(),
              _filterproduct![index].import_price.toString(),
              _filterproduct![index].product_quantity.toString(),
              _filterproduct![index].export_product.toString(),
              _filterproduct![index].import_product.toString(),
            ),
          ),
        ),
      ),
    );
  }
}

class import_prodeuc_menu extends StatefulWidget {
  final source_id,
      product_id,
      product_name,
      product_detail,
      product_image,
      product_price,
      product_quantity,
      export_product,
      import_product;
  import_prodeuc_menu(
      this.source_id,
      this.product_id,
      this.product_name,
      this.product_detail,
      this.product_image,
      this.product_price,
      this.product_quantity,
      this.export_product,
      this.import_product);

  @override
  _import_prodeuc_menuState createState() => _import_prodeuc_menuState();
}

class _import_prodeuc_menuState extends State<import_prodeuc_menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2, right: 2, top: 2),
      height: 225,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.yellow,
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
              widget.product_image.toString(),
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
                    widget.product_name.toString(),
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
                      child: Text('ราคา : ${widget.product_price}'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 5, top: 5, left: 5),
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          height: 30,
                          width: 145,
                          child: OutlinedButton(
                              child: Row(
                                children: const [
                                  Text(
                                    "รายละเอียดสินค้า",
                                    style: TextStyle(color: Colors.black),
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
                                    MaterialPageRoute(builder: (context) {
                                  return import_product_detail(
                                      widget.source_id,
                                      widget.product_id,
                                      widget.product_name,
                                      widget.product_detail,
                                      widget.product_image,
                                      widget.product_price,
                                      widget.product_quantity,
                                      widget.export_product,
                                      widget.import_product);
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
  }
}

class import_product_detail extends StatefulWidget {
  final source_id,
      product_id,
      product_name,
      product_detail,
      product_image,
      product_price,
      product_quantity,
      export_product,
      import_product;
  const import_product_detail(
      this.source_id,
      this.product_id,
      this.product_name,
      this.product_detail,
      this.product_image,
      this.product_price,
      this.product_quantity,
      this.export_product,
      this.import_product,
      {Key? key})
      : super(key: key);

  @override
  State<import_product_detail> createState() => _import_product_detailState();
}

class _import_product_detailState extends State<import_product_detail> {
  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.orangeAccent.withOpacity(0.5),
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: height / 2.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.product_image))),
                )),
            Positioned(
                top: height / 18.76,
                left: height / 42.2,
                right: height / 42.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios)),
                    GestureDetector(
                        onTap: () {},
                        child: AppIcon(icon: Icons.shopping_cart_outlined))
                  ],
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: height / 2.4 - 30,
                child: Container(
                  padding: EdgeInsets.only(
                    left: height / 42.2,
                    right: height / 42.2,
                    top: height / 42.2,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(height / 42.2),
                          topLeft: Radius.circular(height / 42.2)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: "${widget.product_name}",
                        quantity: '${widget.product_quantity.toString()}',
                        sell: '${widget.export_product.toString()}',
                        promotion: '',
                      ),
                      SizedBox(
                        height: height / 42.2,
                      ),
                      Bigtext(
                        text: "แนะนำ",
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: height / 42.2,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableTextWidget(
                              text: "${widget.product_detail}"),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: height / 5.0,
        padding: EdgeInsets.only(
            top: height / 28.13,
            bottom: height / 28.13,
            left: height / 42.2,
            right: height / 42.2),
        decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height / 42.2 * 2),
                topRight: Radius.circular(height / 42.2 * 2))),
        child: Import_quantity(
            widget.product_id, widget.product_price, widget.source_id),
      ),
    );
  }
}

class Import_quantity extends StatefulWidget {
  final product_id, product_price, source_id;
  const Import_quantity(this.product_id, this.product_price, this.source_id,
      {Key? key})
      : super(key: key);

  @override
  State<Import_quantity> createState() => _Import_quantityState();
}

Future<void> _addproducttocart(
    product_id, quantity, product_price, source_id) async {
  Art_Services()
      .import_producttobasket(product_id, quantity, product_price, source_id);
}

class _Import_quantityState extends State<Import_quantity> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            child: const SizedBox(
              width: 20,
              height: 20,
              child: Center(
                  child: Icon(
                Icons.remove,
                size: 20,
              )),
            ),
            onTap: () {
              setState(() {
                quantity--;
              });
            }),
        SizedBox(
          width: height / 84.4 / 2,
        ),
        Bigtext(
          text: quantity.toString(),
          color: Colors.black,
        ),
        SizedBox(
          width: height / 84.4 / 2,
        ),
        InkWell(
            child: const SizedBox(
              width: 20,
              height: 20,
              child: Center(child: Icon(Icons.add, size: 20)),
            ),
            onTap: () {
              setState(() {
                quantity++;
              });
            }),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            try {
              print("---------> ${widget}");
              _addproducttocart(widget.product_id, quantity,
                      widget.product_price, widget.source_id)
                  .then((value) {
                Fluttertoast.showToast(
                    msg: "ซื้อของเรียบร้อย",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.of(context).pop();
              });
            } catch (e) {
              print(e);
              Fluttertoast.showToast(
                  msg: "ของชิ้นนี้ถูกซื้อไปแล้ว",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: Container(
              padding: EdgeInsets.only(
                  top: height / 42.2,
                  bottom: height / 42.2,
                  left: height / 42.2,
                  right: height / 42.2),
              child: Bigtext(
                text: "${widget.product_price} บาท | เพิ่มลงตระกร้า ",
                color: Colors.white,
                size: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height / 42.2),
                color: AppColors.MainColor,
              )),
        ),
      ],
    );
  }
}

class Admincraftimprotproduct extends StatefulWidget {
  final String source_id;
  const Admincraftimprotproduct(this.source_id, {Key? key}) : super(key: key);

  @override
  State<Admincraftimprotproduct> createState() =>
      _AdmincraftimprotproductState();
}

class _AdmincraftimprotproductState extends State<Admincraftimprotproduct> {
  List<Basket>? _basket;
  late int length;
  @override
  void initState() {
    super.initState();
    _basket = [];
    _getBasket();
  }

  _getBasket() {
    print("function working");
    Art_Services().getadminbasket().then((basket) {
      setState(() {
        _basket = basket;
        length = basket.length;
      });
      print("Length ${basket.length}");
      print(_basket![0].product_name);
    });
  }

  _getImportorder(length) {
    int Import_totalprice = 0;
    var Import_order_id = Uuid().v1();
    print('length data for loop === ${length}');
    print('-----------รายการที่จะส่ง-------------');
    print('---รหัสสินค้า [${Import_order_id}]---');
    for (int i = 0; i < length; i++) {
      print('รายการที่[${i}]');
      print(
          'รหัสรายการสิ้นค้า ----> [${_basket![i].basket_product_id.toString()}]');
      print(
          'จำนวนสิ้นค้า ----> [${_basket![i].basket_product_quantity.toString()}]');
      print(
          'ราคารวม ----> [${_basket![i].basket_product_pricetotal.toString()}]');
      print('วันเวลาที่สั่ง ----> [${DateTime.now()}]');
      setState(() {
        Import_totalprice +=
            int.parse(_basket![i].basket_product_pricetotal.toString());
      });
      Art_Services().add_importproduct_detail(
          Import_order_id.toString(),
          _basket![i].basket_product_id.toString(),
          _basket![i].basket_product_quantity.toString(),
          _basket![i].basket_product_pricetotal.toString(),
          DateTime.now().toString());
    }
    print("ราคารวมรายการ : ${Import_totalprice}");

    Art_Services().add_importproduct(
        Import_order_id.toString(),
        Import_totalprice.toString(),
        DateTime.now().toString(),
        widget.source_id.toString());
    print('-----------จบการส่งข้อมูล-------------');
    setState(() {
      Import_totalprice = 0;
    });
    Art_Services().deletebasket().then((value) => {
          Fluttertoast.showToast(
              msg: "สั่งซื้อเสร็จสิ้น",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 4, 255, 0),
              textColor: Colors.white,
              fontSize: 16.0),
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return admin_import_source();
          })),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: () {
              _getImportorder(length);
            },
            label: Text("ยืนยันการสั่งซื้อ"),
            icon: Icon(Icons.shopping_bag),
          ),
        ),
        extendBodyBehindAppBar: true,
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
          backgroundColor: Color(0xFFff8500),
          elevation: 0,
          title: Center(
              child: const Text(
            'รายการสินค้า',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                _getBasket();
              },
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _basket != null ? (_basket?.length ?? 0) : 0,
                itemBuilder: (_, index) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image(
                              image: NetworkImage(
                                  _basket![index].product_image.toString())),
                          title: Text(_basket![index].product_name.toString()),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'จำนวน : ${_basket![index].basket_product_quantity.toString()}'),
                              Text(
                                  'ราคารวม : ${_basket![index].basket_product_pricetotal.toString()}'),
                            ],
                          ),
                          tileColor: Colors.orangeAccent,
                          onTap: () {},
                        ),
                      ),
                    )),
          ),
        ));
  }
}
