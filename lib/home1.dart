import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jackket/HomemapPage.dart';
import 'package:jackket/Homepage.dart';
import 'package:jackket/Jacketpage.dart';
import 'package:jackket/LocalNotifyManager.dart';
import 'package:jackket/Profilepage.dart';

class home1 extends StatefulWidget {
  @override
  _home1State createState() => _home1State();
}

class _home1State extends State<home1> {
  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  DateTime timeBackPressed = DateTime.now();

  final _bottomNavigationBarItem = [
    BottomNavigationBarItem(
      icon: new Image.asset(
        "assets/jacbutton.png",
        scale: 2.5,
      ),
      activeIcon: new Image.asset(
        "assets/jacbuttontap.png",
        scale: 2.5,
      ),
      label: (''),
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
      label: (''),
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
      label: (''),
    ),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        physics: NeverScrollableScrollPhysics(),
        children: [
          JacketPage(),
          HomemapPage(),
          ProfilePage(),
        ],
      ),
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
            onTap: (index) {
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: _bottomNavigationBarItem,
          ),
        ));
  }
}
