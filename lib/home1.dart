import 'package:flutter/material.dart';
import 'package:jackket/Homepage.dart';
import 'package:jackket/Jacketpage.dart';
import 'package:jackket/Profilepage.dart';

class home1 extends StatefulWidget {
  @override
  _home1State createState() => _home1State();
}

class _home1State extends State<home1> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    JacketPage(),
    HomePage(),
    ProfilePage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: _children[_currentIndex],
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
            onTap: onTappedBar,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: new Image.asset(
                  "assets/jacbutton.png",
                  scale: 2.5,
                ),
                activeIcon: new Image.asset(
                  "assets/jacbuttontap.png",
                  scale: 2.5,
                ),
                title: new Text(''),
              ),
              BottomNavigationBarItem(
                icon: new Image.asset(
                  "assets/homebutton.png",
                  scale: 2.5,
                ),
                activeIcon: new Image.asset(
                  "assets/homebuttontap.png",
                  scale: 2.5,
                ),
                title: new Text(''),
              ),
              BottomNavigationBarItem(
                icon: new Image.asset(
                  "assets/profilebutton.png",
                  scale: 2.5,
                ),
                activeIcon: new Image.asset(
                  "assets/profilebuttontap.png",
                  scale: 2.5,
                ),
                title: new Text(''),
              ),
            ],
          ),
        ));
  }
}
