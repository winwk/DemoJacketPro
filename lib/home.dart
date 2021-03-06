import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jackket/home1.dart';
import 'package:jackket/login.dart';
import 'package:jackket/manual.dart';
import 'register.dart';
import 'package:page_transition/page_transition.dart';

class home extends StatefulWidget {
  static String route = "home_SC";
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Widget showTextLogo() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      alignment: Alignment.topCenter,
      child: Text(
        "Jacket",
        style: TextStyle(
          fontSize: 60.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "MPLUSRounded1c",
        ),
      ),
    );
  }

  Widget showTextLogo2() {
    return Container(
      margin: EdgeInsets.zero,
      alignment: Alignment.topCenter,
      child: Text(
        "Detection",
        style: TextStyle(
          fontSize: 60.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "MPLUSRounded1c",
        ),
      ),
    );
  }

  Widget showPic() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [showLogin()],
    );
  }

  Widget showLogin() {
    return Image.asset(
      "assets/login1.png",
      width: 300,
      height: 300,
    );
  }

  Widget showButton() {
    return Column(
      children: [
        showButton1(),
        SizedBox(
          height: 20.0,
        ),
        showButton2()
      ],
    );
  }

  Widget showButton1() {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        child: Text(
          "เข้าสู่ระบบ",
          style: TextStyle(
            fontFamily: "Jasmine",
            color: Color(0xFF707070),
            fontSize: 35.0,
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
                type: PageTransitionType.rightToLeft, child: signin_Screen()),
          );
        },
      ),
    );
  }

  Widget showmanual() {
    return SizedBox(
      width: 100,
      height: 30,
      child: ElevatedButton(
        child: Text(
          "วิธีใช้งาน",
          style: TextStyle(
            fontFamily: "Jasmine",
            color: Color(0xFF707070),
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green[50],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop, child: Manual()),
          );
        },
      ),
    );
  }

  Widget showButton2() {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
          child: Text(
            "ลงทะเบียน",
            style: TextStyle(
              fontFamily: "Jasmine",
              color: Color(0xFF707070),
              fontSize: 35.0,
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
                  child: Register_Screen()),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xFF557B83),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                showTextLogo(),
                showTextLogo2(),
                showPic(),
                showButton(),
                SizedBox(
                  height: 10,
                ),
                showmanual()
              ],
            ),
          )),
    );
  }
}
