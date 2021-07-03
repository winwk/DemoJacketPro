import 'package:flutter/material.dart';

class Register_Screen extends StatefulWidget {
  
  static String route = "register_SC";

  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            centerTitle: true,
            backgroundColor: Color(0xff39AEA9),
            title: Text(
              "ลงทะเบียน",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: "MPLUSRounded1c",
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
