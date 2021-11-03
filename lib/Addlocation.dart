import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationPage extends StatefulWidget {
  _AddLocationPageState createState() => _AddLocationPageState();
}

@override
class _AddLocationPageState extends State<AddLocationPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geoLocator = Geolocator();

  late double savelat;

  late double savelng;
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
            )
          ],
        ),
      ),
    );
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
                  onTap: () {},
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              place(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 450,
                  //width: 300,
                  child: Expanded(
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
                ),
              ),
              // Text(dis.toString())
            ],
          )),
        ));
  }
}
