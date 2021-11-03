import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jackket/AddDevice.dart';
import 'package:jackket/noti.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomemapPage extends StatefulWidget {
  _HomemapPageState createState() => _HomemapPageState();
}

class _HomemapPageState extends State<HomemapPage> {
  final _database = FirebaseDatabase.instance.reference();
  final db = FirebaseDatabase.instance.reference().child("Jacket01/noti");

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geoLocator = Geolocator();
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 15);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future _gotojacket() async {
    LatLng LatLngJac = LatLng(dislat, dislng);
    Marker(
        markerId: MarkerId("2"),
        position: LatLngJac,
        infoWindow: InfoWindow(title: _displayName));
    CameraPosition cameraPosition =
        new CameraPosition(target: LatLngJac, zoom: 15);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static final CameraPosition _jacket =
      CameraPosition(target: LatLng(678, 678), zoom: 10);
  String _displayName = 'Results go here';
  List? date;
  var getPic;
  var jackName;
  var jackID;
  var jackUser;
  var dislat;
  var dislng;

  @override
  void initState() {
    super.initState();
    _checkJacket();
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values['datetime']);
        date = values['datetime'];
      });
    });
  }

  _checkJacket() {
    _database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final user = data['user'] as String;
      final lat = data['lat'];
      print("lat : $lat");
      final lng = data['lng'];
      print("lng : $lng");
      final profileImage = data['imageProfile'];
      setState(() {
        _displayName = user;
        getPic = profileImage;
        dislat = lat;
        dislng = lng;
      });
    });
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      setState(() {
        jackName = value.data()!['JacketName'];
      });
      print("jacketName = $jackName");
    });
  }

  Profile() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      jackName = value.data()!['JacketName'];

      print("jacketName = $jackName");
    });
    if (jackName == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 90),
        child: Text(
          'ไม่พบอุปกรณ์ที่เชื่อมต่อ',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
            fontFamily: "Jasmine",
          ),
        ),
      );
    }
    if (jackName == 'Jacket01') {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SizedBox(
          width: 30,
          height: 70,
          child: ElevatedButton(
            child: Row(
              children: [
                getPic == null
                    ? CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage("assets/person.png"),
                        backgroundColor: Colors.white,
                      )
                    : CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(getPic),
                        backgroundColor: Colors.white,
                      ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  _displayName,
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFE5EFC1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            onPressed: _gotojacket,
          ),
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 90),
        child: Text(
          'ไม่พบอุปกรณ์ที่เชื่อมต่อ',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
            fontFamily: "Jasmine",
          ),
        ),
      );
  }

  Widget showLogo() {
    return Image.asset(
      "assets/BG.png",
      width: 300,
      height: 300,
    );
  }

  Widget showText() {
    return Text(
      'ไม่พบอุปกรณ์ที่เชื่อมต่อ',
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        fontFamily: "Jasmine",
      ),
    );
  }

  Widget sixedbox() {
    return SizedBox(
      width: 150,
      height: 30,
    );
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  Widget showButton() {
    return SizedBox(
      width: 130,
      height: 30,
      child: ElevatedButton(
        child: Text(
          "เพิ่มอุปกรณ์",
          style: TextStyle(
            fontFamily: "Jasmine",
            color: Color(0xFF707070),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFE5EFC1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: AddDevice()),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      jackName = value.data()!['JacketName'];

      print("jacketName = $jackName");
    });
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: IconButton(
                icon: Icon(Icons.notifications,
                    size: 40, color: Color(0xffE5EFC1)),
                onPressed: () {
                  if (jackName == null || jackName == "") {
                    return null;
                  }
                  else {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.bottomToTop, child: noti()),
                  );
                  }
                },
              ),
            )
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          centerTitle: true,
          backgroundColor: Color(0xff39AEA9),
          title: Column(children: [
            box(),
            Text(
              "หน้าหลัก",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: "Jasmine",
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(14.0424397, 100.7387475), zoom: 5),
                      zoomControlsEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controllerGoogleMap.complete(controller);
                        newGoogleMapController = controller;
                        locatePosition();
                      },
                      markers: {
                        jackName != 'Jacket01'
                            ? Marker(
                                //icon: _markerIcon,
                                markerId: MarkerId("1"),
                                position: LatLng(-85.961937, -89.259939),
                                infoWindow: InfoWindow(title: "no"))
                            : Marker(
                                //icon: _markerIcon,
                                markerId: MarkerId("1"),
                                position: LatLng(dislat, dislng),
                                infoWindow: InfoWindow(title: _displayName))
                      }),
                ),
              )
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.16,
            maxChildSize: 0.5,
            minChildSize: 0.16,
            builder: (context, controller) {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: 30,
                        height: 5,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        controller: controller,
                        itemBuilder: (BuildContext context, index) {
                          return Profile();
                        },
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 0,
                          blurRadius: 10),
                    ],
                    color: Color(0xFF557B83),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFF8F9FA),
    );
  }
}
