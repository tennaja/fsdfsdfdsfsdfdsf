// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, avoid_print, unused_local_variable, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_bekery/mysql/service.dart';

class rider_target_map extends StatefulWidget {
  final double taget_latitude, taget_longitude;
  final order_id;
  const rider_target_map(
      this.taget_latitude, this.taget_longitude, this.order_id,
      {Key? key})
      : super(key: key);

  @override
  State<rider_target_map> createState() => _rider_target_mapState();
}

class _rider_target_mapState extends State<rider_target_map> {
  late Position userLocation;
  late GoogleMapController mapController;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final auth = FirebaseAuth.instance;
  Set<Marker> _markers = Set<Marker>();
  late BitmapDescriptor destinationIcon;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

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

  Future<void> acceptdone_task() async {
    CollectionReference user = FirebaseFirestore.instance.collection('order');
    FirebaseFirestore.instance
        .collection('order')
        .get()
        .then((QuerySnapshot querySnapshot) {
      user.doc().update({'order_status': 'ขายสำเร็จ'});
    });
  }

  void initState() {
    super.initState();

    polylinePoints = PolylinePoints();
  }

  Future<void> showPinsOnMap() async {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('value'),
          position: LatLng(widget.taget_latitude, widget.taget_longitude),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    showPinsOnMap();
    setPolylines();
  }

  @override
  Widget build(BuildContext context) {
    polylinePoints = PolylinePoints();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: const Text('แผนที่'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.taget_latitude, widget.taget_longitude),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            child: FloatingActionButton.extended(
              onPressed: () async {
                String email = await SessionManager().get("email");
                Art_Services()
                    .rider_update_order(
                        email, 'ส่งเรียบร้อย', widget.order_id.toString())
                    .then((value) => {
                          Navigator.pop(context),
                          Fluttertoast.showToast(
                              msg: "ยืนยันการส่ง",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color.fromARGB(255, 34, 255, 0),
                              textColor: Colors.white,
                              fontSize: 16.0),
                        });
              },
              label: Text("ยืนยันตำแหน่ง"),
              icon: Icon(Icons.near_me),
            ),
          )
        ],
      ),
    );
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      '',
      PointLatLng(userLocation.latitude, userLocation.longitude),
      PointLatLng(widget.taget_latitude, widget.taget_longitude),
      travelMode: TravelMode.driving,
    );

    if (result.status == 'OK' || result.points.isNotEmpty) {
      print('-----------------------------------------------ok');
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    } else {
      print('----------------------------------------------ไม่โอเคร');
      print(userLocation.latitude);
      print(userLocation.longitude);
      print('---------------------------------------');
      print(widget.taget_latitude);
      print(widget.taget_longitude);
      print(result.toString());
    }
  }
}
