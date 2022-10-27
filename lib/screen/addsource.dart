import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/UI/ComplexDrawerPage.dart';
import 'package:project_bekery/model/promotion_model.dart';
import 'package:project_bekery/model/source_model.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/widgets/adminAppbar.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';

class addsource extends StatefulWidget {
  const addsource({Key? key}) : super(key: key);

  @override
  State<addsource> createState() => _addpromotionState();
}

class _addpromotionState extends State<addsource> {
  List<source>? _source;
  List<source>? _source1;
  int? datalength;
  String? current_sourceid,
      current_sourcename,
      current_sourceaddress,
      current_sourcephone,
      status;
  @override
  void initState() {
    super.initState();
    _source = [];
    _getsource();
    status = 'เพิ่มข้อมูล';
  }

  _getsource() {
    print("function working");
    Art_Services().getSource().then((source) {
      setState(() {
        _source = source;
        datalength = source.length;
      });

      print('จำนวข้อมูล : ${source.length}');
    });
  }

  _updateproducttype(producttype_name) {
    Art_Services().getonly_producttype(producttype_name).toString();
  }

  @override
  Widget build(BuildContext context) {
    final fromKey = GlobalKey<FormState>();
    String? sourcename, sourceaddress, sourcephone;
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.white,
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  status = 'เพิ่มข้อมูล';
                });
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )),
          appBarHeight: 85,
          appBarColor: Color(0xFF5e548e),
          title: Container(
            child: Center(
                child: const Text(
              'เพิ่มแหล่งที่มา',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        slider: ComplexDrawer(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colorz.complexDrawerBlack,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: status == 'เพิ่มข้อมูล'
                      ? Form(
                          key: fromKey,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                onSaved: (name) {
                                  setState(() {
                                    sourcename = name;
                                  });
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  label: Text(
                                    'ชื่อแหล่งที่มา',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                onSaved: (value) {
                                  setState(() {
                                    sourceaddress = value;
                                  });
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  label: Text(
                                    'ที่อยู่',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนข้อมูล"),
                                onSaved: (name) {
                                  setState(() {
                                    sourcephone = name;
                                  });
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  label: Text(
                                    'เบอร์โทรติดต่อ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  //background color of dropdown button
                                  border: Border.all(
                                      color: Colors.black38,
                                      width: 1), //border of dropdown button
                                  borderRadius: BorderRadius.circular(
                                      30), //border raiuds of dropdown button
                                ),
                                child: SizedBox(
                                  width: 350,
                                  height: 40,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF5e548e),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        //////// HERE
                                      ),
                                      child: Text('เพิ่มแหล่งที่มา'),
                                      onPressed: () async {
                                        showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'เพิ่มข้อมูลแหล่งที่มา'),
                                                content: const Text(
                                                    'ต้องการที่จะเพิ่มข้อมูลแหล่งที่มาไหม?'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text("ไม่"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      if (fromKey.currentState!
                                                          .validate()) {
                                                        Utils(context)
                                                            .startLoading();
                                                        fromKey.currentState!
                                                            .save();
                                                        await Art_Services()
                                                            .getonlySource(
                                                                sourcename,
                                                                sourceaddress,
                                                                sourcephone)
                                                            .then((val) {
                                                          print(val.length);
                                                          if (val.length == 0) {
                                                            Art_Services().add_source(
                                                                sourcename
                                                                    .toString(),
                                                                sourceaddress
                                                                    .toString(),
                                                                sourcephone
                                                                    .toString());
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "เพิ่มข้อมูลสำเร็จ",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            13,
                                                                            255,
                                                                            0),
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return addsource();
                                                            }));
                                                          } else {
                                                            Utils(context)
                                                                .stopLoading();
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "ข้อมูลที่กรอกซ้ำ",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: const Text("ใช่"),
                                                  ),
                                                ],
                                              );
                                            });
                                      }),
                                ),
                              ),
                            ],
                          ))
                      : Container(
                          child: Form(
                              key: fromKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: current_sourcename,
                                    style: TextStyle(color: Colors.white),
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    onSaved: (name) {
                                      setState(() {
                                        sourcename = name;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        // width: 0.0 produces a thin "hairline" border
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      label: Text(
                                        'ชื่อแหล่งที่มา',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: current_sourceaddress,
                                    style: TextStyle(color: Colors.white),
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    onSaved: (value) {
                                      setState(() {
                                        sourceaddress = value;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        // width: 0.0 produces a thin "hairline" border
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      label: Text(
                                        'ที่อยู่',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: current_sourcephone,
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนข้อมูล"),
                                    onSaved: (value) {
                                      setState(() {
                                        sourcephone = value;
                                      });
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        // width: 0.0 produces a thin "hairline" border
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      label: Text(
                                        'เบอร์โทรติดต่อ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      //background color of dropdown button
                                      border: Border.all(
                                          color: Colors.black38,
                                          width: 1), //border of dropdown button
                                      borderRadius: BorderRadius.circular(
                                          30), //border raiuds of dropdown button
                                    ),
                                    child: SizedBox(
                                      width: 350,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orangeAccent,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                            //////// HERE
                                          ),
                                          child: Text('แก้ไขแหล่งที่มา'),
                                          onPressed: () async {
                                            showDialog<bool>(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'ออกจากระบบ'),
                                                    content: const Text(
                                                        'ต้องการที่จะออกจากระบบไหม?'),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child:
                                                            const Text("ไม่"),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          if (fromKey
                                                              .currentState!
                                                              .validate()) {
                                                            fromKey
                                                                .currentState!
                                                                .save();
                                                            Utils(context)
                                                                .startLoading();
                                                            await Art_Services()
                                                                .getonlySource(
                                                                    sourcename,
                                                                    sourceaddress,
                                                                    sourcephone)
                                                                .then((val) {
                                                              print(val.length);
                                                              if (val.length ==
                                                                  0) {
                                                                Art_Services().editsource(
                                                                    current_sourceid,
                                                                    sourcename,
                                                                    sourceaddress,
                                                                    sourcephone);
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "แก้ไขข้อมูลสำเร็จ",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity: ToastGravity
                                                                        .BOTTOM,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    backgroundColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            13,
                                                                            255,
                                                                            0),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        16.0);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return addsource();
                                                                }));
                                                              } else {
                                                                Utils(context)
                                                                    .stopLoading();
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "ข้อมูลที่กรอกซ้ำ",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity: ToastGravity
                                                                        .BOTTOM,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    backgroundColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        16.0);
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            });
                                                          }
                                                        },
                                                        child:
                                                            const Text("ใช่"),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          }),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),

                //ตาราง

                Expanded(
                    child: _source?.length != 0
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: DataTable(
                                      columns: [
                                        DataColumn(
                                            label: Text(
                                          'ชื่อแหล่งที่มา',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'ที่อยู่',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'เบอร์ติดต่อ',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'ลบ',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'แก้ไข',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ],
                                      rows: _source!
                                          .map(
                                            (Source) => DataRow(cells: [
                                              DataCell(Text(
                                                Source.source_name.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataCell(Text(
                                                Source.source_address
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataCell(Text(
                                                Source.source_number.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                              DataCell(IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  showDialog<bool>(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'ลบข้อมูล'),
                                                          content: const Text(
                                                              'ต้องการที่จะลบแหล่งที่มาสินค้านี้ใช้ไหม?'),
                                                          actions: <Widget>[
                                                            ElevatedButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child: const Text(
                                                                  "ไม่"),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                Utils(context)
                                                                    .startLoading();
                                                                await Art_Services()
                                                                    .deletesource(Source
                                                                        .source_id
                                                                        .toString());
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "ลบข้อมูลเรียบร้อย",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity: ToastGravity
                                                                        .BOTTOM,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    backgroundColor:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            0,
                                                                            0),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        16.0);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return addsource();
                                                                }));
                                                              },
                                                              child: const Text(
                                                                  "ใช่"),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                              )),
                                              DataCell(IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    current_sourceid =
                                                        Source.source_id;
                                                    current_sourcename =
                                                        Source.source_name;
                                                    current_sourceaddress =
                                                        Source.source_address;
                                                    current_sourcephone =
                                                        Source.source_number;
                                                    status = 'แก้ไขข้อมูล';
                                                  });
                                                },
                                              )),
                                            ]),
                                          )
                                          .toList()),
                                ),
                              ),
                            ),
                          )
                        : Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
