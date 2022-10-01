import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/model/product_promotion.dart';
import 'package:project_bekery/screen/user_order.dart';
import 'package:project_bekery/screen/user_welcome.dart';
import 'package:project_bekery/widgets/app_column.dart';
import 'package:project_bekery/widgets/app_icon.dart';
import 'package:project_bekery/widgets/big_text.dart';
import 'package:project_bekery/widgets/colors.dart';
import 'package:project_bekery/widgets/exandable_text_widget.dart';
import 'dart:async';

import '../login/profire_model/customer_model.dart';
import '../model/product_model.dart';
import '../mysql/service.dart';
import '../mysql/user.dart';
import 'order_rice_sql.dart';

class data_product_sql extends StatefulWidget {
  final String where;
  const data_product_sql(this.where) : super();

  @override
  data_product_sqlState createState() => data_product_sqlState();
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

class data_product_sqlState extends State<data_product_sql> {
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
      print(_product![0].import_price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: _filterproduct != null ? (_filterproduct?.length ?? 0) : 0,
      itemBuilder: (_, index) => Center(
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
            _filterproduct![index].import_price.toString()),
      ),
    );
  }
}

class order_rice_sql extends StatefulWidget {
  final product_id,
      product_name,
      product_detail,
      product_image,
      product_price,
      product_quantity,
      export_product,
      import_product,
      product_type_id,
      proudct_promotion;
  order_rice_sql(
      this.product_id,
      this.product_name,
      this.product_detail,
      this.product_image,
      this.product_price,
      this.product_quantity,
      this.export_product,
      this.import_product,
      this.product_type_id,
      this.proudct_promotion);

  @override
  _order_rice_sqlState createState() => _order_rice_sqlState();
}

class _order_rice_sqlState extends State<order_rice_sql> {
  String? promotionname;
  List<Product_promotion>? _product_promotion;

  void initState() {
    super.initState();
    _getpromotion();
  }

  _getpromotion() {
    print("function working");
    print(
      widget.product_id,
    );
    print(DateFormat('yyyy-MM-d').format(DateTime.now()).toString());
    Art_Services()
        .getonlyvalue_product_promotion(widget.product_id,
            DateFormat('yyyy-MM-d').format(DateTime.now()).toString())
        .then((promotion) {
      setState(() {
        _product_promotion = promotion;
        promotionname = _product_promotion![0].promotion_value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return promotionname == null
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              margin: EdgeInsets.only(left: 2, right: 2, top: 2),
              height: 225,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                      widget.product_image,
                      width: 80,
                      height: 80,
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
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                widget.product_price,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                '${widget.export_product.toString()} ขายแล้ว',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 5),
                              child: Container(
                                  height: 30,
                                  width: 145,
                                  child: OutlinedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  side: BorderSide(
                                                      color: Colors.red)))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "รายละเอียดสินค้า",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11),
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
                                          return product_detail_sql(
                                              widget.product_id.toString(),
                                              widget.product_name.toString(),
                                              widget.product_image.toString(),
                                              widget.product_detail.toString(),
                                              widget.product_price.toString(),
                                              widget.product_quantity
                                                  .toString(),
                                              widget.export_product.toString(),
                                              widget.import_product.toString(),
                                              widget.product_type_id.toString(),
                                              widget.proudct_promotion
                                                  .toString());
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
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Badge(
              elevation: 5,
              animationType: BadgeAnimationType.scale,
              position: BadgePosition.topEnd(),
              badgeContent: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '- ${promotionname}%',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 2, right: 2, top: 2),
                height: 225,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
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
                        widget.product_image,
                        width: 80,
                        height: 80,
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
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  widget.product_price,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Text(
                                  '${widget.export_product.toString()} ขายแล้ว',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 5, top: 5),
                                child: Container(
                                    height: 30,
                                    width: 145,
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    side: BorderSide(
                                                        color: Colors.red)))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "รายละเอียดสินค้า",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11),
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
                                            return product_detail_sql(
                                                widget.product_id.toString(),
                                                widget.product_name.toString(),
                                                widget.product_image.toString(),
                                                widget.product_detail
                                                    .toString(),
                                                widget.product_price.toString(),
                                                widget.product_quantity
                                                    .toString(),
                                                widget.export_product
                                                    .toString(),
                                                widget.import_product
                                                    .toString(),
                                                widget.product_type_id
                                                    .toString(),
                                                widget.proudct_promotion
                                                    .toString());
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
              ),
            ),
          );
  }
}

class product_detail_sql extends StatefulWidget {
  final product_id,
      product_name,
      product_image,
      product_detail,
      product_price,
      product_quantity,
      export_product,
      import_product,
      product_type_id,
      proudct_promotion;
  const product_detail_sql(
      this.product_id,
      this.product_name,
      this.product_image,
      this.product_detail,
      this.product_price,
      this.product_quantity,
      this.export_product,
      this.import_product,
      this.product_type_id,
      this.proudct_promotion,
      {Key? key})
      : super(key: key);

  @override
  State<product_detail_sql> createState() => _product_detail_sqlState();
}

class _product_detail_sqlState extends State<product_detail_sql> {
  List<Product_promotion>? _product_promotion;
  String? promotionname;

  void initState() {
    super.initState();
    _product_promotion = [];
    _getpromotion();
  }

  _getpromotion() {
    print("function working");
    print(
      widget.product_id,
    );
    print(DateFormat('yyyy-MM-d').format(DateTime.now()).toString());
    Art_Services()
        .getonlyvalue_product_promotion(widget.product_id,
            DateFormat('yyyy-MM-d').format(DateTime.now()).toString())
        .then((promotion) {
      setState(() {
        _product_promotion = promotion;
        promotionname = promotion[0].promotion_name;
      });

      print('จำนวข้อมูล : ${promotion.length}');
      print('ชื่อโปรโมชั้น : ${promotion[0].promotion_name}');
      return promotion[0].promotion_name.toString();
    });
  }

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
                        sell: '${widget.export_product.toString()}',
                        quantity: '${widget.product_quantity.toString()}',
                        promotion: '${promotionname}',
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
            widget.product_id, widget.product_price, promotionname.toString()),
      ),
    );
  }
}

class Import_quantity extends StatefulWidget {
  final product_id, product_price, proudct_promotion;
  const Import_quantity(
      this.product_id, this.product_price, this.proudct_promotion,
      {Key? key})
      : super(key: key);

  @override
  State<Import_quantity> createState() => _Import_quantityState();
}

class _Import_quantityState extends State<Import_quantity> {
  int quantity = 1;

  List<Product_promotion>? _product_promotion;
  String? promotionname;
  int? promotionvalue;

  void initState() {
    super.initState();
    _product_promotion = [];
    _getpromotion();
  }

  _getpromotion() {
    print("function working");
    print(
      widget.product_id,
    );
    print(DateFormat('yyyy-MM-d').format(DateTime.now()).toString());
    Art_Services()
        .getonlyvalue_product_promotion(widget.product_id,
            DateFormat('yyyy-MM-d').format(DateTime.now()).toString())
        .then((promotion) {
      setState(() {
        _product_promotion = promotion;
        promotionname = promotion[0].promotion_name;
        promotionvalue = int.parse(promotion[0].promotion_value.toString());
      });

      print('จำนวข้อมูล : ${promotion.length}');
      print('ชื่อโปรโมชั้น : ${promotion[0].promotion_name}');
      return promotion[0].promotion_name.toString();
    });
  }

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
          onTap: () async {
            print('promotionของครั้งนี้ : ${promotionname}');
            print('valuepromotionของครั้งนี้ : ${promotionvalue}');

            String email = await SessionManager().get("email");
            Art_Services().checkuserbasket(widget.product_id).then((value) {
              if (value.isNotEmpty) {
                Fluttertoast.showToast(
                    msg: "มีสิ้นค้าในตระกร้าแล้ว",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 255, 0, 0),
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                print('Promotion : ${widget.proudct_promotion}');
                print('Product_price : ${(widget.product_price.toString())}');
                print('Quantity : ${quantity.toString()}');
                if (promotionname == null) {
                  print('ไม่มีโปรโมชั่น');
                  int totalprice = int.parse(widget.product_price) * quantity;
                  print('Totalprice : ${totalprice.toString()}');
                  Art_Services()
                      .user_add_basket(
                          widget.product_id,
                          quantity.toString(),
                          widget.product_price.toString(),
                          email,
                          'ไม่มีโปรโมชั่น',
                          0.toString())
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "นำสินค้าใส่ตะกร้าเรียบร้อย",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 0, 255, 13),
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Orderpage();
                    }));
                  });
                } else {
                  print('โปรโมชั่นValue : ${promotionvalue} %');
                  int totalprice = int.parse(widget.product_price) * quantity;
                  int totalprice2 = (totalprice *
                          (int.parse(promotionvalue.toString()) / 100))
                      .round();
                  int totalprice3 = totalprice - totalprice2;
                  print('Totalprice : ${totalprice.toString()}');
                  Art_Services()
                      .user_add_basket(
                          widget.product_id,
                          quantity.toString(),
                          widget.product_price.toString(),
                          email,
                          promotionname,
                          promotionvalue.toString())
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "นำสินค้าใส่ตะกร้าเรียบร้อย",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 0, 255, 13),
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Orderpage();
                    }));
                  });
                }
              }
            });
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
