import 'package:flutter/material.dart';
import 'package:jackket/usermanual.dart';

class home extends StatefulWidget {
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
          height: 50.0,
        ),
        showButton2()
      ],
    );
  }

  Widget showButton1() {
    return SizedBox(
      width: 300,
      height: 50,
      child: RaisedButton(
        child: Text(
          "เข้าสู่ระบบ",
          style: TextStyle(
            fontFamily: "MPLUSRounded1c",
            color: Color(0xFF707070),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Color(0xFFE5EFC1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        onPressed: () {},
      ),
    );
  }

  Widget showButton2() {
    return SizedBox(
      width: 300,
      height: 50,
      child: RaisedButton(
          child: Text(
            "ลงทะเบียน",
            style: TextStyle(
              fontFamily: "MPLUSRounded1c",
              color: Color(0xFF707070),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: Color(0xFFE5EFC1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          onPressed: () {
            Navigator.pushNamed(context, userMan.route);
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
                showButton()
              ],
            ),
          )
      ),
    );
  }
}
