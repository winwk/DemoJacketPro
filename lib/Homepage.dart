import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20, top: 10),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.notifications,
                    size: 40, color: Color(0xffE5EFC1)),
              ),
            )
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          centerTitle: true,
          backgroundColor: Color(0xff39AEA9),
          title: Text(
            "หน้าหลัก",
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
