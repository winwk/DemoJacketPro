import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class setnotiPage extends StatefulWidget {
  _setnotiPageState createState() => _setnotiPageState();
}

class _setnotiPageState extends State<setnotiPage> {
  bool isSwitched = false;

  

  @override
  void initState() {
    super.initState();
 checknotiset();

  }
  void checknotiset() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      setState(() {
        isSwitched = value.data()!["statusNoti"];
      });
    });
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            automaticallyImplyLeading: true,
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
              box(),
              Text(
                "ตั้งค่าการแจ้งเตือน",
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
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  height: 80,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("การแจ้งเตือน",
                            style: TextStyle(
                              fontFamily: "Jasmine",
                              color: Color(0xFF707070),
                              fontSize: 35.0,
                            )),
                        SizedBox(
                          width: 110,
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                            FirebaseFirestore.instance
                                .collection("test")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({"statusNoti": isSwitched});
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
