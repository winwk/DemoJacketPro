import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jackket/home.dart';

class Register_Screen extends StatefulWidget {
  static String route = "register";

  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("validate");
    } else {
      print("not validate");
    }
  }

  Widget buildUserName() {
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
                  labelText: "ชื่อ",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
              validator: (String? value) {
                if (value == null || value.trim().length == 0) {
                  return "กรุณาระบุข้อมูล";
                }
                return null;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  hintText: "name@example.com",
                  icon: Icon(Icons.email),
                  labelText: "อีเมล",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
              validator: (String? value) {
                if (value == null || value.trim().length == 0) {
                  return "กรุณาระบุข้อมูล";
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                    .hasMatch(value)) {
                  return "กรุรากรอกอีเมลให้ถูกต้อง";
                }
                return null;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildPassword() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.password_rounded),
                  hintText: "กรอหรหัสผ่านของคุณ...",
                  labelText: "รหัสผ่าน",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
              validator: (String? value) {
                if (value == null || value.trim().length == 0) {
                  return "กรุณาระบุข้อมูล";
                }
                if (value.length <= 6) {
                  return "รหัสผ่านไม่ควรน้อยกว่า 6 ตัวอักษร";
                }
                return null;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget regisButton2() {
    return SizedBox(
        width: 300,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            validator();
          },
          child: Text(
            "ลงทะเบียน",
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
              "ลงทะเบียน",
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildUserName(),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildEmail(),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: 50.0,
                  ),
                  regisButton2()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
