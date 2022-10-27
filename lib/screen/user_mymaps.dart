import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:project_bekery/model/user_maps.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/screen/user_map.dart';
import 'package:project_bekery/widgets/loadingscreen.dart';
import 'package:project_bekery/widgets/userAppbar.dart';

class user_mymapspage extends StatefulWidget {
  const user_mymapspage({Key? key}) : super(key: key);

  @override
  State<user_mymapspage> createState() => _user_mymapspageState();
}

class _user_mymapspageState extends State<user_mymapspage> {
  String? user_email, user_maps_name, user_maps_detail;
  List<User_mymaps>? user_mymaps;
  final fromKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    user_mymaps = [];
    _getusemaps();
  }

  Future<void> _getusemaps() async {
    user_email = await SessionManager().get("email");
    Art_Services().getusermaps(user_email.toString()).then((value) {
      setState(() {
        user_mymaps = value;
      });

      print('จำนวข้อมูล : ${value.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.blue,
          appBarHeight: 85,
          appBarColor: Colors.white,
          title: Container(
            child: Center(
                child: Text(
              'แผนที่ของฉัน',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        slider: UserAppBar(),
        child: Container(
          padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: double.infinity,
            color: Color.fromARGB(255, 238, 238, 238),
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: user_mymaps != null ? (user_mymaps?.length ?? 0) : 0,
              itemBuilder: (_, index) => Center(
                child: Container(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 8.0, bottom: 8.0),
                              child: Container(
                                  child: Card(
                                      elevation: 20,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(children: [
                    ListTile(
                      onTap: () {
                        showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('ยืนยันตำแหน่ง'),
                                content: const Text(
                                    'ต้องการเปลี่ยนเป็นตำแหน่งนี้ใช้ไหม?'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("ไม่"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Utils(context).startLoading();
                                      String user_email =
                                          await SessionManager().get("email");
                                      await Art_Services()
                                          .updatestatususermapall(user_email);
                                      await Art_Services().updatestatususermap(
                                          user_mymaps![index].user_maps_id,
                                          'ใช้งานอยู่');
                                      Fluttertoast.showToast(
                                          msg: "เปลี่ยนตำแหน่งเรียบร้อย",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color.fromARGB(255, 60, 255, 0),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return user_mymapspage();
                                      }));
                                    },
                                    child: const Text("ใช่"),
                                  ),
                                ],
                              );
                            });
                      },
                      leading: Icon(Icons.location_on,color: Colors.blue,),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                final TextEditingController
                                    _TextEditingController =
                                    TextEditingController();
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      content: Form(
                                          key: fromKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                initialValue:
                                                    user_mymaps![index]
                                                        .user_maps_name,
                                                onSaved: (maps_name) {
                                                  user_maps_name = maps_name;
                                                },
                                                validator: RequiredValidator(
                                                    errorText:
                                                        "กรุณาป้อนข้อมูล"),
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    // width: 0.0 produces a thin "hairline" border
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  label: Text(
                                                    'ชื่อสถานที่',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0)),
                                                  ),
                                                  fillColor: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                maxLines: null,
                                                initialValue:
                                                    user_mymaps![index]
                                                        .user_maps_detail,
                                                onSaved: (maps_detail) {
                                                  user_maps_detail =
                                                      maps_detail;
                                                },
                                                validator: RequiredValidator(
                                                    errorText:
                                                        "กรุณาป้อนข้อมูล"),
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    // width: 0.0 produces a thin "hairline" border
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  label: Text(
                                                    'ที่อยู่',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0)),
                                                  ),
                                                  fillColor: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (fromKey.currentState!
                                                    .validate()) {
                                                  Utils(context).startLoading();
                                                  fromKey.currentState!.save();
                                                  print(user_maps_name);
                                                  print(user_maps_detail);
                                                  print(user_mymaps![index]
                                                      .user_maps_id);

                                                  await Art_Services()
                                                      .editusermap(
                                                          user_mymaps![index]
                                                              .user_maps_id,
                                                          user_maps_name,
                                                          user_maps_detail);

                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return user_mymapspage();
                                                  }));

                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "แก้ไขข้อมูลเรียบร้อย",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 60, 255, 0),
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                }
                                              },
                                              child: const Text("แก้ไขข้อมูล"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                await Art_Services()
                                                    .deleteusermap(
                                                        user_mymaps![index]
                                                            .user_maps_id);
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return user_mymapspage();
                                                }));

                                                Fluttertoast.showToast(
                                                    msg: "แก้ไขข้อมูลเรียบร้อย",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 60, 255, 0),
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              },
                                              child: const Text("ลบข้อมูล"),
                                            ),
                                          ],
                                        )
                                      ],
                                      title: Text('แก้ไขข้อมูลแผนที่'),
                                    );
                                  },
                                );
                              });
                        },
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      title: Text(
                          'ชื่อแผนที่ : ${user_mymaps![index].user_maps_name.toString()}'),
                      subtitle: Text(
                        'ที่อยู่ : ${user_mymaps![index].user_maps_detail.toString()}',
                        maxLines: 1,
                      ),
                    ),
                  ]),
                ),
              ),
            )),
      ),
    ))));
  }
}
