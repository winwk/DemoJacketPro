import 'package:flutter/material.dart';

class home1 extends StatefulWidget {
  @override
  _home1State createState() => _home1State();
}

class _home1State extends State<home1> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20, top: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
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
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Home'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              backgroundColor: Colors.blue),
        ],
      ),
      backgroundColor: Color(0xFF557B83),
    );
  }
}
