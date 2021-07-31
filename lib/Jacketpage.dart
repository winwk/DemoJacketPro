import 'package:flutter/material.dart';
import 'package:jackket/AddDevice.dart';
import 'package:page_transition/page_transition.dart';

class JacketPage extends StatefulWidget {
  _JacketPageState createState() => _JacketPageState();
}

class _JacketPageState extends State<JacketPage> {
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
              showLogo(),
              showText(),
              sixedbox(),
              showButton()
            ],
          ),
        ),
      ),
    );
  }
}
