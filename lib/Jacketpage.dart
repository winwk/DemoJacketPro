import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jackket/AddDevice.dart';
import 'package:jackket/JacketProfile.dart';
import 'package:jackket/user/showListofUsers.dart';
import 'package:page_transition/page_transition.dart';

class JacketPage extends StatefulWidget {
  _JacketPageState createState() => _JacketPageState();
}

class _JacketPageState extends State<JacketPage> {
  CollectionReference _jackCollection =
      FirebaseFirestore.instance.collection("Jacket01");

  var jackName;
  var jackID;

  getUid() {
    _jackCollection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print("++++++++++++++++++++++++++++");
        print(doc.data());
        print(doc.id);
      });
    });
  }

  checkPic() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      print(value.data()!['JacketName']);
      jackName = value.data()!['JacketName'];
    });
  }

  Widget getJacket() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      print(value.data()!['JacketName']);
      jackName = value.data()!['JacketName'];
    });
    _jackCollection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print("++++++++++++++++++++++++++++");
        print(doc.data());
        print(doc.id);
        jackID = doc.id;
      });
    });
    if (jackName == null) {
      return Card();
    }
    return SizedBox(
      width: 350,
      height: 70,
      child: Card(
        child: Text(jackName),
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

  showText() {
    if (jackName != null) {
      return Text('');
    }
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

  showButton() {
    if (jackName == null) {
      return SizedBox(
        width: 150,
        height: 50,
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
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        child: Text(
          "ตั้งค่าอุปกรณ์",
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
                type: PageTransitionType.bottomToTop, child: JacketPro()),
          );
        },
      ),
    );
  }

  Widget testButton() {
    return SizedBox(
      width: 130,
      height: 30,
      child: ElevatedButton(
        child: Text(
          "Test",
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
        onPressed: () {},
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getJacket(),
              sixedbox(),
              showText(),
              sixedbox(),
              showButton(),
              showLogo(),
            ],
          ),
        ),
      ),
    );
  }
}
