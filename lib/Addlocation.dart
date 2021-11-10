import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jackket/home1.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationPage extends StatefulWidget {
  _AddLocationPageState createState() => _AddLocationPageState();
}

@override
class _AddLocationPageState extends State<AddLocationPage> {
  final database = FirebaseDatabase.instance.reference();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Position currentPosition;
  var geoLocator = Geolocator();

  var savelat;

  var savelng;
  var jackId;

  String? titleString;
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

  @override
  void initState() {
    super.initState();
    database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final sendJackID = data['sendJackID'];
      setState(() {
        jackId = sendJackID;
      });
    });
  }

  List<Marker> myMarker = [];
  Widget place() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  //hintText: "name@example.com",
                  icon: Icon(
                    Icons.location_city,
                  ),
                  labelText: "ชื่อสถานที่",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
              validator: (String? value) {
                if (value == null || value.trim().length == 0) {
                  return "กรุณาระบุข้อมูล";
                }
                return null;
              },
              onSaved: (String? value) {
                titleString = value;
              },
            )
          ],
        ),
      ),
    );
  }

  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("validate");
    } else {
      print("not validate");
    }
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF557B83),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            automaticallyImplyLeading: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    if (savelat == null) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              title: Text(
                                'กรุณาระบุตำแหน่ง',
                                style: TextStyle(
                                  fontFamily: "Jasmine",
                                  color: Color(0xFF707070),
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      child: Text(
                                        "ตกลง",
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    } else if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      database.child('$jackId/savelocate').push().set({
                        'title': titleString,
                        'lat': savelat,
                        'lng': savelng
                      });

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              title: Text(
                                'เพิ่มสถานที่เสร็จสิ้น',
                                style: TextStyle(
                                  fontFamily: "Jasmine",
                                  color: Color(0xFF707070),
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      child: Text(
                                        "ตกลง",
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      onPressed: () {
                                        _formKey.currentState?.reset();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        home1()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    }
                  },
                  child: Icon(Icons.check_circle_rounded,
                      size: 42, color: Colors.white),
                ),
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.only(left: 15, top: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child:
                    Icon(Icons.cancel_rounded, size: 42, color: Colors.white),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            centerTitle: true,
            backgroundColor: Color(0xff39AEA9),
            title: Column(children: [
              box(),
              Text(
                "เพิ่มสถานที่",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Jasmine",
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Stack(children: <Widget>[
            Column(
              children: [
                place(),
                Expanded(
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
                    onTap: (LatLng taplatlng) {
                      //print(taplatlng);
                      setState(() {
                        savelat = taplatlng.latitude;
                        savelng = taplatlng.longitude;
                        myMarker = [];
                        myMarker.add(Marker(
                          markerId: MarkerId(taplatlng.toString()),
                          position: taplatlng,
                        ));
                      });
                      print('lat: $savelat');
                      print('lng: $savelng');
                    },
                    markers: Set.from(myMarker),
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}
