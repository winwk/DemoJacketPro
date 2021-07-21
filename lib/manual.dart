import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jackket/home.dart';
import 'package:jackket/register.dart';

class Manual extends StatefulWidget {
  static var route;

  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF2F4F4F),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF557B83),
                Color(0xFF557B83),
                Color(0xFF557B83),
                Color(0xFF557B83),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                  'Jacket',
                                  style: TextStyle(
                                    fontSize: 50.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MPLUSRounded1c",
                                  ),
                                ),
                                SizedBox(height: 1.0),
                                Text(
                                  'Detection',
                                  style: TextStyle(
                                    fontSize: 50.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "MPLUSRounded1c",
                                  ),
                                ),
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/logo.png',
                                    ),
                                    height: 250.0,
                                    width: 250.0,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'แอพพลิเคชั่นสำหรับระบุตำแหน่งของ',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'ผู้พิการทางด้านสายตาตลอดเวลาเพื่อให้ผู้ใช้',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'ไม่ต้องกังวลว่าคนที่คุณรักจะเดินทาง',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'ไปไหนมาไหนแล้วจะเดินชนสิ่งกีดขวาง',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'เพราะจะมีการแจ้งเตือนให้ผู้ใช้ทราบตลอดเวลา',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                              ])),
                      Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/logo2.png',
                                    ),
                                    height: 400.0,
                                    width: 500.0,
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'แสดงตำแหน่งของผู้ที่สวมใส่แจ็คเก็ต',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'ได้แบบเรียลไทม์และยังสามารถดู',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'สถานะการเชื่อมต่อของแจ็คเก็ตแต่ละตัวได้',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                              ])),
                      Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/logo3.png',
                                    ),
                                    height: 400.0,
                                    width: 500.0,
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'สามารถเพิ่มและจัดการแก้ไข',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'โปรไฟล์ของแจ็คเก็ตแต่ละตัวได้',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontFamily: "Jasmine"),
                                ),
                              ])),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/logo4.png',
                                  ),
                                  height: 400.0,
                                  width: 500.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'จัดการและแก้ไขข้อมูลบัญชีของผู้ดูแล',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontFamily: "Jasmine"),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'และสามารถตั้งค่าการแจ้งเตือนได้',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontFamily: "Jasmine"),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                  
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: 
      _currentPage == _numPages - 1
          ? Container(
              height: 60.0,
              margin: EdgeInsets.all(0),
              width: 150,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: FlatButton(
                  child: Text(
                    "เริ่มต้นใช้งาน",
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 30.0,
                      fontFamily: "Jasmine",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (_currentPage == _numPages - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => home()),
                      );
                    }
                  },
                  color: Color(0xFFE5EFC1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ))
          : Text(''),
    );
    return scaffold;
  }
}
