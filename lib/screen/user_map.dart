// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, avoid_print, unused_local_variable, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/widgets/userAppbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class user_MapsPage extends StatefulWidget {
  const user_MapsPage({Key? key}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<user_MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final auth = FirebaseAuth.instance;
  Set<Marker> _markers = Set<Marker>();
  late BitmapDescriptor destinationIcon;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  String Address = 'search';
  final fromKey = GlobalKey<FormState>();
  String? user_email, user_maps_name, user_maps_detail;

  Future<Position> _getLocation() async {
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // ignore: empty_catches
    } catch (e) {}
    return userLocation;
  }

  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future GetAddressFromLatLong(latitude, longitude) async {
    List placemarks = await placemarkFromCoordinates(latitude, longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      Address = '${place.street}';
    });
  }

  Future<void> showInFrom(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _TextEditingController =
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
                          onSaved: (maps_name) {
                            user_maps_name = maps_name;
                          },
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
                          autofocus: false,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            label: Text(
                              'ชื่อสถานที่',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            fillColor: Color.fromARGB(255, 0, 0, 0),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: null,
                          initialValue: Address,
                          onSaved: (maps_detail) {
                            user_maps_detail = maps_detail;
                          },
                          validator:
                              RequiredValidator(errorText: "กรุณาป้อนข้อมูล"),
                          autofocus: false,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            label: Text(
                              'ที่อยู่',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            fillColor: Color.fromARGB(255, 0, 0, 0),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    )),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      if (fromKey.currentState!.validate()) {
                        fromKey.currentState!.save();
                        user_email = await SessionManager().get("email");
                        print(user_email);
                        print(user_maps_name);
                        print(user_maps_detail);
                        print(userLocation.latitude);
                        print(userLocation.longitude);
                        await Art_Services()
                            .add_user_maps(
                                user_email.toString(),
                                user_maps_name.toString(),
                                user_maps_detail.toString(),
                                userLocation.latitude.toString(),
                                userLocation.longitude.toString())
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "เพิ่มแผนที่เรียบร้อย",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color.fromARGB(255, 60, 255, 0),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return user_MapsPage();
                          }));
                        });
                      }
                    },
                    child: const Text("ยืนยันการเพิ่ม"),
                  ),
                ],
                title: Text('เพิ่มแผนที่ของฉัน'),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    polylinePoints = PolylinePoints();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: Colors.blue,
          trailing: IconButton(
              onPressed: () async {
                await mapController.animateCamera(CameraUpdate.newLatLngZoom(
                    LatLng(userLocation.latitude, userLocation.longitude), 18));
                await GetAddressFromLatLong(
                    userLocation.latitude, userLocation.longitude);
                print(Address);
                showInFrom(context);
              },
              icon: Icon(Icons.near_me,color: Colors.blue,)),
          appBarHeight: 85,
          appBarColor: Colors.white,
          title: Container(
            child: Center(
                child: const Text(
              'แผนที่ยืนยันตำแหน่ง',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        slider: UserAppBar(),
        child: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target:
                        LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 15),
                markers: _markers,
                polylines: _polylines,
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
