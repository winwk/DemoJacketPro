
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'register.dart';

class Manual extends StatelessWidget {

  static String route = "manual_SC";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: PageViewDemo(),
        ),
      ),
    );
  }
}

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        MyPage1Widget(),
        MyPage2Widget(),
        MyPage3Widget(),
        MyPage4Widget(),
      ],
    );
  }
}

class MyPage1Widget extends StatefulWidget{
  @override
  _MyPage1WidgetState createState() => _MyPage1WidgetState();
}
class _MyPage1WidgetState extends State<MyPage1Widget> {
  @override
  Widget showTextLogo() {
    return Container(
      margin: EdgeInsets.only(top: 100.0),
      alignment: Alignment.topCenter,
      child: Text(
        "Jacket",
        style: TextStyle(
          fontSize: 60.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "MPLUSRounded1c",
        ),
      ),
    );
  }

  Widget showLogo() {
    return Container(
        margin: EdgeInsets.only(top: 50),
        child: Image.asset("assets/logo.png"));
  }

  Widget showTextLogo2() {
    return Container(
      margin: EdgeInsets.zero,
      alignment: Alignment.topCenter,
      child: Text(
        "Detection",
        style: TextStyle(
          fontSize: 60.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "MPLUSRounded1c",
        ),
      ),
    );
  }

  Widget showText() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(
            "แอพพลิเคชั่นสำหรับระบุตำแหน่งของ",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "ผู้พิการทางด้านสายตาตลอดเวลาเพื่อให้ผู้ใช้",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "ไม่ต้องกังวลว่าคนที่คุณรักจะเดินทาง",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "ไปไหนมาไหนแล้วจะเดินชนสิ่งกีดขวาง",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "เพราะจะมีการแจ้งเตือนให้ผู้ใช้ทราบตลอดเวลา",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        body: Column(
          children: [
            showTextLogo(),
            showTextLogo2(),
            showLogo(),
            showText(),
          ],
        ),
      ),
    );
  }
}

class MyPage2Widget extends StatefulWidget{
  @override
  _MyPage2WidgetState createState() => _MyPage2WidgetState();
}
class _MyPage2WidgetState extends State<MyPage2Widget> {
  @override
  Widget showLogo2() {
    return Container(
        margin: EdgeInsets.only(top: 100),
        child: Image.asset(
          "assets/logo2.png",
          width: 400,
          height: 500,
        ));
  }

  Widget showText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(
            "แสดงตำแหน่งของผู้ที่สวมใส่แจ็คเก็ต",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "ได้แบบเรียลไทม์และยังสามารถดู",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "สถานะการเชื่อมต่อของแจ็คเก็ตแต่ละตัวได้",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        body: Column(
          children: [
            showLogo2(),
            showText(),
          ],
        ),
      ),
    );
  }
}

class MyPage3Widget extends StatefulWidget{
  @override
  _MyPage3WidgetState createState() => _MyPage3WidgetState();
}
class _MyPage3WidgetState extends State<MyPage3Widget> {
  @override
  Widget showLogo3() {
    return Container(
        margin: EdgeInsets.only(top: 100),
        child: Image.asset(
          "assets/logo3.png",
          width: 400,
          height: 500,
        ));
  }

  Widget showText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(
            "สามารถเพิ่มและจัดการแก้ไข",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "โปรไฟล์ของแจ็คเก็ตแต่ละตัวได้",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        body: Column(
          children: [
            showLogo3(),
            showText(),
          ],
        ),
      ),
    );
  }
}

class MyPage4Widget extends StatefulWidget{
  @override
  _MyPage4WidgetState createState() => _MyPage4WidgetState();
}
class _MyPage4WidgetState extends State<MyPage4Widget> {
   Widget showLogo4() {
       return Container(
        margin: EdgeInsets.only(top: 100),
        child: Image.asset(
          "assets/logo4.png",
          width: 400,
          height: 500,
        ));
  }

  Widget showText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(
            "จัดการและแก้ไขข้อมูลบัญชีของผู้ดูแล",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
          Text(
            "และสามารถตั้งค่าการแจ้งเตือนได้",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: "MPLUSRounded1c"),
          ),
        ],
      ),
    );
  }

  Widget nextButton(){
    return ElevatedButton(
      onPressed: (){
        Navigator.pushNamed(context, home.route);
      }, child: Text("เริ่มต้นการใช้งาน")
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        body: Column(
          children: [
            showLogo4(),
            showText(),
            nextButton()
          ],
        ),
      ),
    );
  }
  }

