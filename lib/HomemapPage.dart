import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jackket/AddDevice.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomemapPage extends StatefulWidget {
  _HomemapPageState createState() => _HomemapPageState();
}

class _HomemapPageState extends State<HomemapPage> {
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
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 23, top: 7),
                child: PopupMenuButton<int>(
                  offset: const Offset(-35, 70),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  icon: Icon(Icons.notifications,
                      size: 40, color: Color(0xffE5EFC1)),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Center(
                        child: Text(
                          "การแจ้งเตือน",
                          style: TextStyle(
                            fontFamily: "Jasmine",
                            color: Color(0xFF707070),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      height: 25,
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      child: Center(
                        child: Text("ไม่มีการแจ้งเตือน"),
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: SizedBox(
                        height: 5,
                        width: 300,
                      ),
                    ),
                  ],
                ))
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
                  ),
                ),
              )
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            maxChildSize: 0.5,
            minChildSize: 0.15,
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
                        itemCount: 13,
                        controller: controller,
                        itemBuilder: (BuildContext context, index) {
                          return ListTile(
                            title: Text('Item ${index + 1}'),
                          );
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