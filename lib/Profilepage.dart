import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jackket/ChangeProfile.dart';
import 'package:jackket/changepassword.dart';
import 'package:jackket/home.dart';
import 'package:jackket/setnoti.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isBackButtonActivated = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? displayName;

  
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<Null> findDisplayName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        displayName = event!.displayName;
        print('##### displayName = $displayName#######');
      });
    });
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  Widget test() {
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
            CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage("assets/person.png"),
              backgroundColor: Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '$displayName',
              style: TextStyle(
                fontFamily: "Jasmine",
                color: Color(0xFF707070),
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(auth.currentUser!.email!,
                style: TextStyle(
                  fontFamily: "Jasmine",
                  color: Color(0xFF707070),
                  fontSize: 30.0,
                )),
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
                  type: PageTransitionType.rightToLeft, child: ChangeProfile()),
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

  Widget changepassButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" เปลี่ยนรหัสผ่าน",
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
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: Changepass()),
            );
          }),
    );
  }

  Widget notisetButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: setnotiPage()),
          );
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" ตั้งค่าการแจ้งเตือน",
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
        width: 160,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            auth.signOut().then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return home();
              }));
            });
          },
          child: Text(
            "ออกจากระบบ",
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

  Widget build(BuildContext context) {
    return Scaffold(
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
              "โปรไฟล์",
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
                test(),
                SizedBox(
                  height: 15.0,
                ),
                EditProButton(),
                SizedBox(
                  height: 15.0,
                ),
                changepassButton(),
                SizedBox(
                  height: 15.0,
                ),
                notisetButton(),
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
      backgroundColor: Color(0xFF557B83),
    );
  }
}
