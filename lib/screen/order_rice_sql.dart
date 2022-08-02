import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../login/profire_model/customer_model.dart';
import '../model/product_model.dart';
import '../mysql/service.dart';
import '../mysql/user.dart';
import 'order_rice_sql.dart';

class data_product_sql extends StatefulWidget {
  //
  data_product_sql() : super();

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
    print("function working");
    Services().getProduct().then((product) {
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: _filterproduct != null ? (_filterproduct?.length ?? 0) : 0,
      itemBuilder: (_, index) => Center(
        child: order_rice_sql(
            _filterproduct![index].product_name.toString(),
            _filterproduct![index].product_detail.toString(),
            _filterproduct![index].product_image.toString(),
            _filterproduct![index].product_price.toString(),
            _filterproduct![index].product_quantity.toString(),
            _filterproduct![index].export_product.toString(),
            _filterproduct![index].import_product.toString()),
      ),
    );
  }
}

class order_rice_sql extends StatefulWidget {
  final product_name,
      product_detail,
      product_image,
      product_price,
      product_quantity,
      export_product,
      import_product;
  order_rice_sql(
      this.product_name,
      this.product_detail,
      this.product_image,
      this.product_price,
      this.product_quantity,
      this.export_product,
      this.import_product);

  @override
  _order_rice_sqlState createState() => _order_rice_sqlState();
}

class _order_rice_sqlState extends State<order_rice_sql> {
  @override
  Widget build(BuildContext context) {
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
              widget.product_image,
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
                      child: Text(widget.product_price),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        '${widget.export_product.toString()} ขายแล้ว',
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
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
                                /*
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return productdetail(
                                      data['product_id'].toString(),
                                    );
                                  }));
                                */
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
