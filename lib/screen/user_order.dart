// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace, non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/screen/order_rice.dart';
import 'package:project_bekery/screen/order_rice_sql.dart';
import 'cart_order_add.dart';
import 'float_add_order.dart';
import 'home.dart';

class Orderpage extends StatelessWidget {
  const Orderpage({Key? key}) : super(key: key);

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
            child: const Text(
          'รายการสินค้า',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        )),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {
              // do somethingNavigator.push(context,
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return cart_order_add();
              }));
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Color.fromRGBO(30, 246, 30, 10),
            child: Center(
              child: Icon(
                Icons.add_circle_rounded,
                size: 50,
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return add_product_order();
              }));
            },
          ),
        ),
      ),
      body: Container(
        color: Colors.orangeAccent.withOpacity(0.5),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
          child: ListView(
            children: [
              CarouselSlider(
                  items: [
                    Image.network(
                        'https://www.igetweb.com/themes_v2/portal/assets/img/hero-promotion/promotion-2-detail.jpg'),
                    Image.network(
                        'https://www.igetweb.com/themes_v2/portal/assets/img/hero-promotion/promotion-1-detail.jpg'),
                    Image.network(
                        'https://www.friendtellpro.com/wp-content/uploads/2020/09/5f4f86c5N7a6e748c.jpg.dpg_.jpeg')
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("ข้าวสาร"), Text("ทั้งหมด")],
                ),
              ),*/
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 225.0,
                child: order_rice('ข้าวสาร'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 225.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: <Widget>[
                        data_product_sql(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
