import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jackket/ChangeDistance.dart';
import 'package:jackket/ChangeProJacket.dart';
import 'package:jackket/EditDevice.dart';
import 'package:jackket/HomemapPage.dart';
import 'package:jackket/Homepage.dart';
import 'package:jackket/Locationpage.dart';
import 'package:jackket/Videopage.dart';
import 'package:jackket/home.dart';
import 'package:jackket/home1.dart';
import 'package:jackket/noti.dart';
import 'package:jackket/status.dart';
import 'package:page_transition/page_transition.dart';

class JacketPro extends StatefulWidget {
  JacketPro({Key? key}) : super(key: key);

  @override
  _JacketProState createState() => _JacketProState();
}

class _JacketProState extends State<JacketPro> {
  final firestoreRef = FirebaseFirestore.instance;
  var getPic;
  var JackUser;
  var jackId;
  final _database = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final sendJackID = data['sendJackID'];
      //print(profileImage);
      setState(() {
        jackId = sendJackID;
      });
      _database.child('$jackId').onValue.listen((event) {
        final data = new Map<String, dynamic>.from(event.snapshot.value);
        final profileImage = data['imageProfile'];
        //print(profileImage);
        final user = data['user'] as String;
        setState(() {
          JackUser = user;
          getPic = profileImage;
        });
      });
    });
  }

  Widget getProfileJack() {
    return SizedBox(
      width: 355,
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            getPic == null
                ? CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage("assets/person.png"),
                    backgroundColor: Colors.white,
                  )
                : CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(getPic),
                    backgroundColor: Colors.white,
                  ),
            SizedBox(
              height: 32,
            ),
            Text("ชื่อโปรไฟล์ : $JackUser",
                style: TextStyle(
                  fontFamily: "Jasmine",
                  color: Color(0xFF707070),
                  fontSize: 35.0,
                ))
          ],
        ),
      ),
    );
  }

  Widget EditProButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: ChangeProJacket()),
          );
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" แก้ไขโปรไฟล์",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget EditToolButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: EditDevice()),
          );
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" เปลี่ยนรหัสผ่านอุปกรณ์",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget LocationButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: LocationPage()),
          );
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" สถานที่ที่บันทึกไว้",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget VideoButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: VideoPage()),
          );
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" วิดีโอที่บันทึกไว้",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget NotificationButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: ChangeDistance()),
          );
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" ตั้งค่าระยะที่แจ้งเตือน",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget StatusButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: Status()),
          );
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" สถานะการทำงาน",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget notiButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(type: PageTransitionType.rightToLeft, child: noti()),
          );
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" การแจ้งเตือน",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget LogoutButton() {
    return SizedBox(
        width: 150,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text(
                      'ลบโปรไฟล์',
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
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ElevatedButton(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              onPressed: () {
                                var val = [];
                                if (jackId != null) {
                                  val.add(jackId);
                                }
                                FirebaseFirestore.instance
                                    .collection("test")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "JacketName": FieldValue.arrayRemove(val)
                                });

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => home1()),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                          ElevatedButton(
                            child: Text(
                              "ยกเลิก",
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
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
          },
          child: Text(
            "ลบอุปกรณ์",
            style: TextStyle(
                fontFamily: "Jasmine",
                color: Color(0xFF707070),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFFFAAAA),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            automaticallyImplyLeading: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 8),
                child: IconButton(
                  icon: Icon(Icons.notifications,
                      size: 40, color: Color(0xffE5EFC1)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.topToBottom, child: noti()),
                    );
                  },
                ),
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.only(left: 15, top: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/backbutton.png',
                  scale: 12,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            centerTitle: true,
            backgroundColor: Color(0xff39AEA9),
            title: Column(children: [
              SizedBox(
                height: 20,
              ),
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
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  getProfileJack(),
                  SizedBox(
                    height: 15.0,
                  ),
                  EditProButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  EditToolButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  LocationButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  VideoButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  NotificationButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  LogoutButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteRecord(String id) async {
    print(id);
  }
}
