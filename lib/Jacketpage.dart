import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jackket/API/notification_api.dart';
import 'package:jackket/AddDevice.dart';
import 'package:jackket/ChangeProJacket.dart';
import 'package:jackket/JacketProfile.dart';
import 'package:jackket/JacketProfileNoti.dart';
import 'package:jackket/LocalNotifyManager.dart';
import 'package:jackket/user/showListofUsers.dart';
import 'package:page_transition/page_transition.dart';

class JacketPage extends StatefulWidget {
  _JacketPageState createState() => _JacketPageState();
}

class _JacketPageState extends State<JacketPage> {
  CollectionReference _jackCollection =
      FirebaseFirestore.instance.collection("Jacket01");
  final _database = FirebaseDatabase.instance.reference();

  String _displayName = '';
  String _displayName02 = '';

  var getPic;
  var jackName;
  var jackName02;
  var getPic02;

  var noti;
  var date;

  var noti02;
  var date02;

  var statusNoti;

  @override
  void initState() {
    super.initState();
    _checkJacket();

    // localNotifyManager.showNotification();
    // Timer.run(() => _database.child('Jacket01/notinow').remove());
  }

  _checkJacket() {
    final Jacket01Ref = _database.child('/Jacket01');
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      setState(() {
        jackName = value.data()!['JacketName'][0];
        jackName02 = value.data()!['JacketName'][1];
        statusNoti = value.data()!['statusNoti'];
      });
      print("jacketName = $jackName");
      print("jacketName02 =$jackName02");
      print("statusnoti =$statusNoti");
    });
    _database.child("Jacket01").onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final user = data['user'] as String;
      final profileImage = data['imageProfile'];

      _displayName = user;
      getPic = profileImage;
    });
    _database.child("Jacket02").onValue.listen((event) {
      final data02 = new Map<String, dynamic>.from(event.snapshot.value);
      final user02 = data02['user'] as String;
      final profileImage02 = data02['imageProfile'];
      _displayName02 = user02;
      getPic02 = profileImage02;
    });

    if (jackName == "Jacket01" && jackName02 == "Jacket02") {
      _database.child("Jacket01/notinow").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) async {
          noti = values['title'];
          date = values['datetime'];
          print("noti = $noti");
          if (statusNoti == false) {
            return Timer.run(
                () => _database.child('Jacket01/notinow').remove());
          }
          if (noti == null || noti == "") {
            return null;
          } else {
            await NotificationApi.showNotification(
                title: '$noti  จาก $_displayName',
                body: '$date',
                payload: 'NEW payload Jacket01 ');
            Timer.run(() => _database.child('Jacket01/notinow').remove());
          }
        });
      });
      _database.child("Jacket02/notinow").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) async {
          noti02 = values['title'];
          date02 = values['datetime'];
          print("noti = $noti");
          if (statusNoti == false) {
            return Timer.run(
                () => _database.child('Jacket02/notinow').remove());
          }
          if (noti02 == null || noti02 == "") {
            return null;
          } else {
            await NotificationApi.showNotification(
                title: '$noti02   จาก $_displayName02',
                body: '$date02',
                payload: 'NEW payload Jacket02 ');
            Timer.run(() => _database.child('Jacket02/notinow').remove());
          }
        });
      });
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: getPic == null
                            ? CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                                backgroundColor: Colors.white,
                              )
                            : CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(getPic),
                                backgroundColor: Colors.white,
                              ),
                      ),
                      Text(
                        _displayName,
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Color(0xFF707070),
                            fontFamily: "Jasmine",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: IconButton(
                            onPressed: () {
                              Jacket01Ref.update({'sendJackID': "Jacket01"});
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: JacketPro()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xff39AEA9),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: getPic02 == null
                            ? CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                                backgroundColor: Colors.white,
                              )
                            : CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(getPic02),
                                backgroundColor: Colors.white,
                              ),
                      ),
                      Text(
                        _displayName02,
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Color(0xFF707070),
                            fontFamily: "Jasmine",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: IconButton(
                            onPressed: () {
                              Jacket01Ref.update({'sendJackID': "Jacket02"});

                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: JacketPro()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xff39AEA9),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "เพิ่มอุปกรณ์",
                    style: TextStyle(
                      fontFamily: "Jasmine",
                      color: Color(0xFF707070),
                      fontSize: 25.0,
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
                          type: PageTransitionType.rightToLeft,
                          child: AddDevice()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
    if (jackName02 == "Jacket01" && jackName == "Jacket02") {
      _database.child("Jacket01/notinow").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) async {
          noti = values['title'];
          date = values['datetime'];
          print("noti = $noti");
          if (statusNoti == false) {
            return Timer.run(
                () => _database.child('Jacket01/notinow').remove());
          }
          if (noti == null || noti == "") {
            return null;
          } else {
            await NotificationApi.showNotification(
                title: '$noti  จาก  $_displayName',
                body: '$date',
                payload: 'NEW payload Jacket01 ');
            Timer.run(() => _database.child('Jacket01/notinow').remove());
          }
        });
      });
      _database.child("Jacket02/notinow").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) async {
          noti02 = values['title'];
          date02 = values['datetime'];
          print("noti = $noti");
          if (statusNoti == false) {
            return Timer.run(
                () => _database.child('Jacket02/notinow').remove());
          }
          if (noti02 == null || noti02 == "") {
            return null;
          } else {
            await NotificationApi.showNotification(
                title: '$noti02   จาก $_displayName02',
                body: '$date02',
                payload: 'NEW payload Jacket02 ');
            Timer.run(() => _database.child('Jacket02/notinow').remove());
          }
        });
      });

      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: getPic == null
                            ? CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                                backgroundColor: Colors.white,
                              )
                            : CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(getPic),
                                backgroundColor: Colors.white,
                              ),
                      ),
                      Text(
                        _displayName,
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Color(0xFF707070),
                            fontFamily: "Jasmine",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: IconButton(
                            onPressed: () {
                              Jacket01Ref.update({'sendJackID': "Jacket01"});
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: JacketPro()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xff39AEA9),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: getPic02 == null
                            ? CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                                backgroundColor: Colors.white,
                              )
                            : CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(getPic02),
                                backgroundColor: Colors.white,
                              ),
                      ),
                      Text(
                        _displayName02,
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Color(0xFF707070),
                            fontFamily: "Jasmine",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: IconButton(
                            onPressed: () {
                              Jacket01Ref.update({'sendJackID': "Jacket02"});

                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: JacketPro()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xff39AEA9),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "เพิ่มอุปกรณ์",
                    style: TextStyle(
                      fontFamily: "Jasmine",
                      color: Color(0xFF707070),
                      fontSize: 25.0,
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
                          type: PageTransitionType.rightToLeft,
                          child: AddDevice()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
    if (jackName == "Jacket01" && jackName02 == null) {
      _database.child("Jacket01/notinow").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) async {
          noti = values['title'];
          date = values['datetime'];
          print("noti = $noti");
          if (statusNoti == false) {
            return Timer.run(
                () => _database.child('Jacket01/notinow').remove());
          }
          if (noti == null || noti == "") {
            return null;
          } else {
            await NotificationApi.showNotification(
                title: '$noti  จาก $_displayName',
                body: '$date',
                payload: 'NEW payload Jacket01 ');
            Timer.run(() => _database.child('Jacket01/notinow').remove());
          }
        });
      });
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: getPic == null
                            ? CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                                backgroundColor: Colors.white,
                              )
                            : CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(getPic),
                                backgroundColor: Colors.white,
                              ),
                      ),
                      Text(
                        _displayName,
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Color(0xFF707070),
                            fontFamily: "Jasmine",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: IconButton(
                            onPressed: () {
                              Jacket01Ref.update({'sendJackID': "Jacket01"});
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: JacketPro()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xff39AEA9),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "เพิ่มอุปกรณ์",
                    style: TextStyle(
                      fontFamily: "Jasmine",
                      color: Color(0xFF707070),
                      fontSize: 25.0,
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
                          type: PageTransitionType.rightToLeft,
                          child: AddDevice()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
    if (jackName == "Jacket02" && jackName02 == null) {
      _database.child("Jacket02/notinow").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) async {
          noti02 = values['title'];
          date02 = values['datetime'];
          print("noti = $noti");
          if (statusNoti == false) {
            return Timer.run(
                () => _database.child('Jacket02/notinow').remove());
          }
          if (noti02 == null || noti02 == "") {
            return null;
          } else {
            await NotificationApi.showNotification(
                title: '$noti02   จาก $_displayName02',
                body: '$date02',
                payload: 'NEW payload Jacket02 ');
            Timer.run(() => _database.child('Jacket02/notinow').remove());
          }
        });
      });
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: getPic02 == null
                            ? CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                                backgroundColor: Colors.white,
                              )
                            : CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(getPic02),
                                backgroundColor: Colors.white,
                              ),
                      ),
                      Text(
                        _displayName02,
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Color(0xFF707070),
                            fontFamily: "Jasmine",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: IconButton(
                            onPressed: () {
                              Jacket01Ref.update({'sendJackID': "Jacket02"});
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: JacketPro()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xff39AEA9),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "เพิ่มอุปกรณ์",
                    style: TextStyle(
                      fontFamily: "Jasmine",
                      color: Color(0xFF707070),
                      fontSize: 25.0,
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
                          type: PageTransitionType.rightToLeft,
                          child: AddDevice()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
    if (jackName == null && jackName02 == "Jacket01") {
      _database.child("Jacket01/notinow").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) async {
          noti = values['title'];
          date = values['datetime'];
          print("noti = $noti");
          if (statusNoti == false) {
            return Timer.run(
                () => _database.child('Jacket01/notinow').remove());
          }
          if (noti == null || noti == "") {
            return null;
          } else {
            await NotificationApi.showNotification(
                title: '$noti  จาก $_displayName',
                body: '$date',
                payload: 'NEW payload Jacket01 ');
            Timer.run(() => _database.child('Jacket01/notinow').remove());
          }
        });
      });
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: getPic == null
                            ? CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                                backgroundColor: Colors.white,
                              )
                            : CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(getPic),
                                backgroundColor: Colors.white,
                              ),
                      ),
                      Text(
                        _displayName,
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Color(0xFF707070),
                            fontFamily: "Jasmine",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: IconButton(
                            onPressed: () {
                              Jacket01Ref.update({'sendJackID': "Jacket01"});
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: JacketPro()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xff39AEA9),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "เพิ่มอุปกรณ์",
                    style: TextStyle(
                      fontFamily: "Jasmine",
                      color: Color(0xFF707070),
                      fontSize: 25.0,
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
                          type: PageTransitionType.rightToLeft,
                          child: AddDevice()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
    if (jackName == null && jackName02 == "Jacket02") {
      _database.child("Jacket02/notinow").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) async {
          noti02 = values['title'];
          date02 = values['datetime'];
          print("noti = $noti");
          if (statusNoti == false) {
            return Timer.run(
                () => _database.child('Jacket02/notinow').remove());
          }
          if (noti02 == null || noti02 == "") {
            return null;
          } else {
            await NotificationApi.showNotification(
                title: '$noti02   จาก $_displayName02 ',
                body: '$date02',
                payload: 'NEW payload Jacket02 ');
            Timer.run(() => _database.child('Jacket02/notinow').remove());
          }
        });
      });
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: 350,
                height: 100,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: getPic02 == null
                            ? CircleAvatar(
                                radius: 35.0,
                                backgroundImage:
                                    AssetImage("assets/person.png"),
                                backgroundColor: Colors.white,
                              )
                            : CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(getPic02),
                                backgroundColor: Colors.white,
                              ),
                      ),
                      Text(
                        _displayName02,
                        style: TextStyle(
                            fontSize: 45.0,
                            color: Color(0xFF707070),
                            fontFamily: "Jasmine",
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 5),
                        child: IconButton(
                            onPressed: () {
                              Jacket01Ref.update({'sendJackID': "Jacket02"});
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: JacketPro()),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: Color(0xff39AEA9),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "เพิ่มอุปกรณ์",
                    style: TextStyle(
                      fontFamily: "Jasmine",
                      color: Color(0xFF707070),
                      fontSize: 25.0,
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
                          type: PageTransitionType.rightToLeft,
                          child: AddDevice()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }

    if (jackName == null && jackName02 == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            SizedBox(
              child: Text(
                'ไม่พบอุปกรณ์ที่เชื่อมต่อ',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: "Jasmine",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "เพิ่มอุปกรณ์",
                    style: TextStyle(
                      fontFamily: "Jasmine",
                      color: Color(0xFF707070),
                      fontSize: 25.0,
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
                          type: PageTransitionType.rightToLeft,
                          child: AddDevice()),
                    );
                  },
                ),
              ),
            ),
            showLogo()
          ],
        ),
      );
    }
  }

  Widget showLogo() {
    return Image.asset(
      "assets/BG.png",
      width: 300,
      height: 300,
    );
  }

  Widget showText() {
    if (jackName == null) {
      return Text(
        'ไม่พบอุปกรณ์ที่เชื่อมต่อ',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.white,
          fontFamily: "Jasmine",
        ),
      );
    } else {
      return Text('');
    }
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
      width: 150,
      height: 50,
      child: ElevatedButton(
        child: Text(
          "เพิ่มอุปกรณ์",
          style: TextStyle(
            fontFamily: "Jasmine",
            color: Color(0xFF707070),
            fontSize: 25.0,
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
                type: PageTransitionType.rightToLeft, child: AddDevice()),
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          centerTitle: true,
          backgroundColor: Color(0xff39AEA9),
          title: Column(children: [
            box(),
            Text(
              "แจ็คเก็ต",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: "Jasmine",
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
      backgroundColor: Color(0xFF557B83),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _checkJacket(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
