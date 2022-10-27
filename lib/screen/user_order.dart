// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace, non_constant_identifier_names

import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/model/product_model.dart';
import 'package:project_bekery/model/producttype.dart';
import 'package:project_bekery/model/promotion_model.dart';
import 'package:project_bekery/model/user_basket.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/mysql/user.dart';
import 'package:project_bekery/screen/order_rice.dart';
import 'package:project_bekery/screen/order_rice_sql.dart';
import 'package:project_bekery/widgets/userAppbar.dart';
import 'cart_order_add.dart';
import 'float_add_order.dart';
import 'home.dart';

class Orderpage extends StatefulWidget {
  const Orderpage({Key? key}) : super(key: key);

  @override
  State<Orderpage> createState() => _OrderpageState();
}

class _OrderpageState extends State<Orderpage> {
  List<User_Basket>? userbasket;
  List<Producttype>? producttype;
  int? length, producttypelenght;
  int totalprice = 0;
  @override
  void initState() {
    length ??= 0;
    super.initState();
    userbasket = [];
    producttype = [];
    _getBasket();
    _getallproducttype();
  }

  _getBasket() async {
    String email = await SessionManager().get("email");
    print("function working");
    Art_Services().getuserbasket(email.toString()).then((basket) {
      setState(() {
        userbasket = basket;
        length = basket.length;
      });
      print("Length ${basket.length}");
    });
  }

  _getallproducttype() {
    Art_Services().getall_producttype().then((value) {
      setState(() {
        producttype = value;
        producttypelenght = value.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.blue,
          appBarHeight: 85,
          appBarColor: Colors.white,
          title: Container(
            child: Center(
                child: const Text(
              'รายการสินค้า',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
          ),
          trailing: Badge(
            animationType: BadgeAnimationType.scale,
            position: BadgePosition.bottomStart(bottom: 5, start: 4),
            badgeContent: Text('${length.toString()}'),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.blue,
              ),
              onPressed: () async {
                String email = await SessionManager().get("email");
                // do somethingNavigator.push(context,
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return cart_order_add(email);
                }));
              },
            ),
          ),
        ),
        slider: UserAppBar(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 238, 238, 238),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: ListView(
              children: [
                CarouselSlider(
                    items: [
                      InkWell(
                        child: Image.asset(
                          'assets/images/promotion1.jpg',
                        ),
                        onTap: () {
                          print('object');
                        },
                      ),
                      Image.asset('assets/images/promotion2.jpg'),
                      Image.asset('assets/images/promotion3.jpg'),
                      Image.asset('assets/images/promotion4.jpg'),
                      Image.asset('assets/images/promotion5.jpg'),
                    ],
                    options: CarouselOptions(
                      height: 150,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    )),
                /*Container(
                  height: 50.0,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.greenAccent),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return data_product_sql_more('1');
                              }));
                            },
                            child: Text('ข้าวสาร'),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.greenAccent),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return data_product_sql_more('2');
                              }));
                            },
                            child: Text('อุปกรณ์เครื่องใช้ในครัว'),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.greenAccent),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return data_product_sql_more('3');
                              }));
                            },
                            child: Text('เครื่องปรุง'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),*/

                Container(
                  height: 55.0,
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:
                          producttype != null ? (producttype?.length ?? 0) : 0,
                      itemBuilder: (_, index) => Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: producttype![index].product_type_id == '0'
                                  ? Container()
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return data_product_sql_more(
                                              producttype![index]
                                                  .product_type_id
                                                  .toString());
                                        }));
                                      },
                                      child: Text(producttype![index]
                                          .product_type_name
                                          .toString(),style: TextStyle(color: Colors.blue),),
                                    ),
                            ),
                          )),
                ),
                /*
                Container(
                  height: 230,
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:
                          producttype != null ? (producttype?.length ?? 0) : 0,
                      itemBuilder: ((_, index) => data_product_sql('1'))),
                ),*/
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 225.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: <Widget>[
                          data_product_sql('1'),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 225.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: <Widget>[
                          data_product_sql('2'),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 225.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: <Widget>[
                          data_product_sql('3'),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class data_product_sql_more extends StatefulWidget {
  final String where;
  const data_product_sql_more(this.where) : super();

  @override
  data_product_sql_moreState createState() => data_product_sql_moreState();
}

// Now we will write a class that will help in searching.
// This is called a Debouncer class.
// I have made other videos explaining about the debouncer classes
// The link is provided in the description or tap the 'i' button on the right corner of the video.
// The Debouncer class helps to add a delay to the search
// that means when the class will wait for the user to stop for a defined time
// and then start searching
// So if the user is continuosly typing without any delay, it wont search
// This helps to keep the app more performant and if the search is directly hitting the server
// it keeps less hit on the server as well.
// Lets write the Debouncer class

class data_product_sql_moreState extends State<data_product_sql_more> {
  List<Product>? _product;
  List<Product>? _filterproduct;
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  User? _selectedUser;

  @override
  void initState() {
    super.initState();
    _product = [];
    _getProduct();
  }

  _getProduct() {
    print('ข้อมูล : ${widget.where}');
    Art_Services().getonlyProduct(widget.where).then((product) {
      print(
          "------------------------------------------------------------------------");
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
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
            child: const Text(
          'รายการสินค้า',
          style: TextStyle(
              color: Colors.blue,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () async {
              String email = await SessionManager().get("email");
              // do somethingNavigator.push(context,
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return cart_order_add(email);
              }));
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 238, 238, 238),
        child: GridView.builder(
          itemCount: _filterproduct != null ? (_filterproduct?.length ?? 0) : 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.79),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: order_rice_sql(
              _filterproduct![index].product_id.toString(),
              _filterproduct![index].product_name.toString(),
              _filterproduct![index].product_detail.toString(),
              _filterproduct![index].product_image.toString(),
              _filterproduct![index].product_price.toString(),
              _filterproduct![index].product_quantity.toString(),
              _filterproduct![index].export_product.toString(),
              _filterproduct![index].import_product.toString(),
              _filterproduct![index].product_type_id.toString(),
              _filterproduct![index].import_price.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
