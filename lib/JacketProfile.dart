import 'package:flutter/material.dart';

class JacketPro extends StatefulWidget {
  JacketPro({Key? key}) : super(key: key);

  @override
  _JacketProState createState() => _JacketProState();
}

class _JacketProState extends State<JacketPro> {
  Widget test() {
    return SizedBox(
      width: 300,
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [],
        ),
      ),
    );
  }

  Widget EditProButton() {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Color(0xFF707070),
          ),
        ),
        label: Text("แก้ไขโปรไฟล์",
            style: TextStyle(
                fontFamily: "MPLUSRounded1c",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    );
  }

  Widget EditToolButton() {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Color(0xFF707070),
          ),
        ),
        label: Text("แก้ไขอุปกรณ์",
            style: TextStyle(
                fontFamily: "MPLUSRounded1c",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    );
  }

  Widget LocationButton() {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Color(0xFF707070),
          ),
        ),
        label: Text("สถานที่ที่บันทึกไว้",
            style: TextStyle(
                fontFamily: "MPLUSRounded1c",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    );
  }

  Widget VideoButton() {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.only(right: 45),
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Color(0xFF707070),
          ),
        ),
        label: Text("วิดีโอที่บันทึกไว้",
            style: TextStyle(
                fontFamily: "MPLUSRounded1c",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    );
  }

  Widget NotificationButton() {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Color(0xFF707070),
          ),
        ),
        label: Text("ตั้งค่าระยะที่แจ้งเตือน",
            style: TextStyle(
                fontFamily: "MPLUSRounded1c",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    );
  }

  Widget StatusButton() {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Color(0xFF707070),
          ),
        ),
        label: Text("สถานะการทำงาน",
            style: TextStyle(
                fontFamily: "MPLUSRounded1c",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    );
  }

  Widget LogoutButton() {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "ออกจากระบบ",
            style: TextStyle(
                fontFamily: "MPLUSRounded1c",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFFFAAAA),
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
              "แจ็คเก็ต",
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
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  test(),
                  SizedBox(
                    height: 25.0,
                  ),
                  EditProButton(),
                  SizedBox(
                    height: 25.0,
                  ),
                  EditToolButton(),
                  SizedBox(
                    height: 25.0,
                  ),
                  LocationButton(),
                  SizedBox(
                    height: 25.0,
                  ),
                  VideoButton(),
                  SizedBox(
                    height: 25.0,
                  ),
                  NotificationButton(),
                  SizedBox(
                    height: 25.0,
                  ),
                  StatusButton(),
                  SizedBox(
                    height: 25.0,
                  ),
                  LogoutButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
