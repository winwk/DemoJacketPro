import 'package:flutter/material.dart';
import 'package:jackket/JacketProfile.dart';

class EditDevice extends StatefulWidget {
  @override
  _EditDeviceState createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  Widget DeviceName() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: "ชื่ออุปกรณ์",
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

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("validate");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JacketPro()),
      );
    } else {
      print("not validate");
    }
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
                  hintText: "กรอกรหัสผ่านของคุณ...",
                  labelText: "รหัสผ่านปัจจุบัน",
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

  Widget newPassword() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            obscureText: true,
            controller: _passwordController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return "กรุณาระบุข้อมูล";
              } else if (value.length < 6) {
                return "รหัสผ่านไม่ควรน้อยกว่า 6 ตัวอักษร";
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: "รหัสผ่านใหม่",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ))),
          ),
        ]),
      ),
    );
  }

  Widget confirmPassword() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: TextFormField(
              obscureText: true,
              controller: _confirmPasswordController,
              validator: (String? value) {
                if (value != _passwordController.value.text) {
                  return 'รหัสผ่านไม่ตรงกัน!';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "ยืนยันรหัสผ่าน",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
            ))
          ],
        ),
      ),
    );
  }

  Widget Button() {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            validator();
          },
          child: Text(
            "ยืนยัน",
            style: TextStyle(
                fontFamily: "Jasmine",
                color: Color(0xFF707070),
                fontSize: 30.0,
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
              box(),
              Text(
                "แก้ไขอุปกรณ์",
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
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DeviceName(),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: 30.0,
                  ),
                  newPassword(),
                  SizedBox(
                    height: 30.0,
                  ),
                  confirmPassword(),
                  SizedBox(
                    height: 30.0,
                  ),
                  Button(),
                  SizedBox(
                    height: 30.0,
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