import 'package:flutter/material.dart';
import 'package:jackket/Addlocation.dart';
import 'package:page_transition/page_transition.dart';

class LocationPage extends StatefulWidget {
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            automaticallyImplyLeading: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: AddLocationPage()),
                    );
                  },
                  child: Icon(Icons.add_circle_rounded,
                      size: 42, color: Colors.white),
                ),
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.only(left: 15, top: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/backbutton.png',
                  scale: 12,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            centerTitle: true,
            backgroundColor: Color(0xff39AEA9),
            title: Column(children: [
              box(),
              Text(
                "สถานที่ที่บันทึกไว้",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Jasmine",
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
        //body: ,
      ),
    );
  }
}
