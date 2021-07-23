import 'package:flutter/material.dart';

class JacketPro extends StatefulWidget {
  JacketPro({Key? key}) : super(key: key);

  @override
  _JacketProState createState() => _JacketProState();
}

class _JacketProState extends State<JacketPro> {
  Widget test() {
    return SizedBox(
      width: 355,
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
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" แก้ไขโปรไฟล์",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget EditToolButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" แก้ไขอุปกรณ์",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget LocationButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" สถานที่ที่บันทึกไว้",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget VideoButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" วิดีโอที่บันทึกไว้",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget NotificationButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" ตั้งค่าระยะที่แจ้งเตือน",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget StatusButton() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" สถานะการทำงาน",
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 35.0,
                  )),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color(0xFF707070),
              ),
            ]),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  Widget LogoutButton() {
    return SizedBox(
        width: 150,
        height: 40,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "ลบโปรไฟล์",
            style: TextStyle(
                fontFamily: "Jasmine",
                color: Color(0xFF707070),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFFFAAAA),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF557B83),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            automaticallyImplyLeading: true,
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
              SizedBox(
                height: 20,
              ),
              Text(
                "แจ็คเก็ต",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Jasmine",
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  test(),
                  SizedBox(
                    height: 15.0,
                  ),
                  EditProButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  EditToolButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  LocationButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  VideoButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  NotificationButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  StatusButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  LogoutButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
