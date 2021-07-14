import 'package:flutter/material.dart';

class home1 extends StatefulWidget {
  @override
  _home1State createState() => _home1State();
}

class _home1State extends State<home1> {
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
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
      backgroundColor: Color(0xFF557B83),
    );
  }

  Widget get bottomNavigationBar {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: new Image.asset(
                  "assets/jacbutton.png",
                  scale: 2.5,
                ),
                title: new Text(''),
              ),
              BottomNavigationBarItem(
                icon: new Image.asset(
                  "assets/homebutton.png",
                  scale: 2.5,
                ),
                title: new Text(''),
              ),
              BottomNavigationBarItem(
                icon: new Image.asset(
                  "assets/profilebutton.png",
                  scale: 2.5,
                ),
                title: new Text(''),
              ),
            ],
          ),
        ));
  }
}
