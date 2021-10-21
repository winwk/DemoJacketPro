import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jackket/AddDevice.dart';
import 'package:jackket/ChangeProJacket.dart';
import 'package:jackket/JacketProfile.dart';
import 'package:jackket/notitest.dart';
import 'package:jackket/read_examples.dart';
import 'package:jackket/user/showListofUsers.dart';
import 'package:jackket/write_examples.dart';
import 'package:page_transition/page_transition.dart';

class JacketPage extends StatefulWidget {
  _JacketPageState createState() => _JacketPageState();
}

class _JacketPageState extends State<JacketPage> {
  CollectionReference _jackCollection =
      FirebaseFirestore.instance.collection("Jacket01");
  final _database = FirebaseDatabase.instance.reference();
  String _displayName = 'Results go here';
  var getPic;
  var jackName;
  var jackID;
  var jackUser;

  @override
  void initState() {
    super.initState();
    _checkJacket();
  }

  _checkJacket() {
    _database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final user = data['user'] as String;
      final profileImage = data['imageProfile'];
      _displayName = user;
      getPic = profileImage;
      print(_displayName);
    });
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      //print(value.data()!['JacketName']);
      jackName = value.data()!['JacketName'];
    });

    if (jackName == null) {
      return Card();
    } else {
      return SingleChildScrollView(
        child: SizedBox(
          width: 350,
          height: 100,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                getPic == null
                    ? CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage("assets/person.png"),
                        backgroundColor: Colors.white,
                      )
                    : CircleAvatar(
                        radius: 35.0,
                        backgroundImage: NetworkImage(getPic),
                        backgroundColor: Colors.white,
                      ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  _displayName,
                  style: TextStyle(
                      fontSize: 45.0,
                      color: Color(0xFF707070),
                      fontFamily: "Jasmine",
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  // getUid() {
  //   _jackCollection.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       print("++++++++++++++++++++++++++++");
  //       print(doc.data());
  //       print(doc.id);
  //     });
  //   });
  // }

  // checkJacket() {
  //   var firebaseUser = FirebaseAuth.instance.currentUser;
  //   FirebaseFirestore.instance
  //       .collection("test")
  //       .doc(firebaseUser!.uid)
  //       .get()
  //       .then((value) {
  //     print(value.data()!['JacketName']);
  //   });
  // }

  // check() {
  //   FirebaseFirestore.instance
  //       .collection("Jacket01")
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print('#################');
  //       print(result.data()['user']);
  //     });
  //   });
  // }

  // getJacket() {
  //   var firebaseUser = FirebaseAuth.instance.currentUser;
  //   FirebaseFirestore.instance
  //       .collection("test")
  //       .doc(firebaseUser!.uid)
  //       .get()
  //       .then((value) {
  //     //print(value.data()!['JacketName']);
  //     jackName = value.data()!['JacketName'];
  //   });
  //   _jackCollection.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       // print("++++++++++++++++++++++++++++");
  //       // print(doc.data());
  //       // print(doc.id);
  //       jackID = doc.id;
  //     });
  //   });
  //   FirebaseFirestore.instance
  //       .collection("Jacket01")
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print('#################');
  //       print(result.data()['user']);
  //       jackUser = result.data()['user'];
  //     });
  //   });
  //   if (jackName == null) {
  //     return Card();
  //   }
  //   return SizedBox(
  //     width: 350,
  //     height: 70,
  //     child: Card(
  //       child: Text(
  //         jackUser,
  //         style: TextStyle(
  //           fontFamily: "Jasmine",
  //           color: Color(0xFF707070),
  //           fontSize: 30.0,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget test() {
    return SingleChildScrollView(
      child: SizedBox(
        width: 350,
        height: 100,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              SizedBox(
                width: 40,
              ),
              getPic == null
                  ? CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage("assets/person.png"),
                      backgroundColor: Colors.white,
                    )
                  : CircleAvatar(
                      radius: 35.0,
                      backgroundImage: NetworkImage(getPic),
                      backgroundColor: Colors.white,
                    ),
              SizedBox(
                width: 40,
              ),
              Text(
                _displayName,
                style: TextStyle(
                    fontSize: 45.0,
                    color: Color(0xFF707070),
                    fontFamily: "Jasmine",
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
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

  Widget testButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: notitest()),
        );
      },
      child: Text('test'),
    );
  }

  Widget showButton() {
    if (jackName != null) {
      return SizedBox(
        width: 300,
        height: 60,
        child: ElevatedButton(
          child: Text(
            "ตั้งค่าอุปกรณ์อุปกรณ์",
            style: TextStyle(
              fontFamily: "Jasmine",
              color: Color(0xFF707070),
              fontSize: 30.0,
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
                  type: PageTransitionType.rightToLeft, child: JacketPro()),
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
                sixedbox(),
                _checkJacket(),
                showLogo(),
                showText(),
                sixedbox(),
                showButton(),
                testButton(),
                sixedbox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
