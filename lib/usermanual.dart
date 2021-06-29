import 'package:flutter/material.dart';

class userMan extends StatefulWidget {
  @override
  _userManState createState() => _userManState();
}

class _userManState extends State<userMan> {
  Widget showTextLogo() {
    return Container(
      margin: EdgeInsets.only(top: 100.0),
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

  Widget showLogo() {
    return Container(
        margin: EdgeInsets.only(top: 50),
        child: Image.asset("assets/logo.png"));
  }

  Widget showText() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Text(
            "แอพพลิเคชั่นสำหรับระบุตำแหน่งของผู้พิการทางด้านสายตา",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "ตลอดเวลาเพื่อให้ผู้ใช้ไม่ต้องกังวลว่าคนที่คุณรัก",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "จะเดินทางไปไหนมาไหนแล้วจะเดินชนสิ่งกีดขวาง",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "เพราะจะมีการแจ้งเตือนให้ผู้ใช้ทราบตลอดเวลา 5555555 เจษและวีนเด็กเหี้ย",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        body: Column(
          children: [
            showTextLogo(),
            showTextLogo2(),
            showLogo(),
            showText(),
          ],
        ),
      ),
    );
  }
}
