// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, avoid_print, unused_local_variable, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/mysql/service.dart';
import 'package:project_bekery/widgets/userAppbar.dart';

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
  String googleAPiKey = 'AIzaSyC_P2HO1gBwXbfe1XXlKDlC-3RomyMnORA';
  double _destLatitude = 13.687151;
  double _destLongitude = 100.622185;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

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

  @override
  Widget build(BuildContext context) {
    polylinePoints = PolylinePoints();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SliderDrawer(
        appBar: SliderAppBar(
          trailing: IconButton(
              onPressed: () {
                setPolylines();
                mapController.animateCamera(CameraUpdate.newLatLngZoom(
                    LatLng(userLocation.latitude, userLocation.longitude), 18));
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                          'Your location has been send !\nlat: ${userLocation.latitude} long: ${userLocation.longitude} '),
                    );
                  },
                );
              },
              icon: Icon(Icons.near_me)),
          appBarHeight: 85,
          appBarColor: Colors.greenAccent,
          title: Container(
            child: Center(
                child: const Text(
              'แผนที่ยืนยันตำแหน่ง',
              style: TextStyle(
                  color: Colors.black,
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

  void setPolylines() async {
    print('------WORKING-------');
    String user_email = await SessionManager().get("email");
    print(userLocation.latitude.toString());
    print(userLocation.longitude.toString());
    print(user_email.toString());
    Art_Services()
        .update_map_user(userLocation.latitude.toString(),
            userLocation.longitude.toString(), user_email.toString())
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "แก้ไขข้อมูลเรียบร้อย",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color.fromARGB(255, 9, 255, 0),
                  textColor: Colors.white,
                  fontSize: 16.0),
            });
  }
}
