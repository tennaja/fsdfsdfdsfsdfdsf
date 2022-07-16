// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unused_field, avoid_print, unused_local_variable, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

    polylinePoints = PolylinePoints();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
                  target: LatLng(userLocation.latitude, userLocation.longitude),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setPolylines();
          _usersCollection
              .doc("${auth.currentUser!.email}")
              .update({
                'u_latitude': userLocation.latitude,
                'u_longitude': userLocation.longitude
              })
              .then((value) => print("User Updated"))
              .catchError((error) => print("Failed to update user: $error"));
          print("${auth.currentUser!.email}");
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
        label: Text("ยืนยันพิกัดที่อยู่"),
        icon: Icon(Icons.near_me),
      ),
    );
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyC_P2HO1gBwXbfe1XXlKDlC-3RomyMnORA',
      PointLatLng(userLocation.latitude, userLocation.longitude),
      PointLatLng(_destLatitude, _destLongitude),
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
      print(_destLatitude);
      print(_destLongitude);
      print(result.toString());
    }
  }
}
