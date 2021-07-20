import 'package:flutter/material.dart';

class JacketPage extends StatefulWidget {
  _JacketPageState createState() => _JacketPageState();
}

class _JacketPageState extends State<JacketPage> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          centerTitle: true,
          backgroundColor: Color(0xff39AEA9),
          title: Text(
            "แจ็คเก็ต",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: "MPLUSRounded1c",
                fontSize: 45.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Color(0xFF557B83),
    );
  }
}
