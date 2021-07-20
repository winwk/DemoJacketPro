import 'package:flutter/material.dart';

class signin_Screen extends StatefulWidget {
  static String route = "sign_SC";
  @override
  _signin_ScreenState createState() => _signin_ScreenState();
}

class _signin_ScreenState extends State<signin_Screen> {
  Widget email() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.face),
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

  Widget PassWord() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.password_sharp),
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

  Widget SignInButton() {
    return SizedBox(
        width: 300,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => signin_Screen()),
            );
          },
          child: Text(
            "เข้าสู่ระบบ",
            style: TextStyle(
                fontFamily: "MPLUSRounded1c",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFE5EFC1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
        ));
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
              "เข้าสู่ระบบ",
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
               SizedBox(
                height: 30.0,
              ),
              email(),
              SizedBox(
                height: 25.0,
              ),
              PassWord(),
              SizedBox(
                height: 60.0,
              ),
              SignInButton()
            ],
          ),
        ),
      ),
    );
  }
}