import 'package:flutter/material.dart';
import 'package:jackket/home.dart';

class Register_Screen extends StatefulWidget {
  static String route = "register";
  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  String password = "";

  Widget nametext() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.face),
                  labelText: "ชื่อ",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
            )
          ],
        ),
      ),
    );
  }

  Widget emailtext() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  hintText: "name@example.com",
                  icon: Icon(Icons.email),
                  labelText: "อีเมล",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
            )
          ],
        ),
      ),
    );
  }

  Widget buildpassword() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.password_rounded),
                  hintText: "กรอหรหัสผ่านของคุณ...",
                  labelText: "รหัสผ่าน",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
            )
          ],
        ),
      ),
    );
  }

  Widget NextButton2() {
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
            
          }),
    );
  }

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
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              nametext(),
              SizedBox(
                height: 20.0,
              ),
              emailtext(),
              SizedBox(
                height: 20.0,
              ),
              buildpassword(),
              SizedBox(
                height: 50.0,
              ),
              NextButton2()
            ],
          ),
        ),
      ),
    );
  }
}
