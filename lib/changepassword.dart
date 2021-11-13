import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jackket/JacketProfile.dart';
import 'package:jackket/Profilepage.dart';
import 'package:jackket/login.dart';

class Changepass extends StatefulWidget {
  Changepass({Key? key}) : super(key: key);
  static String route = "Change";
  @override
  _ChangepassState createState() => _ChangepassState();
}

class _ChangepassState extends State<Changepass> {
  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

    final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {

    if (emailController.text == auth.currentUser!.email!) {
      try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Text(
                'ส่งอีเมลรีเซ็ตรหัสผ่านแล้ว !',
                style: TextStyle(
                  fontFamily: "Jasmine",
                  color: Color(0xFF707070),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text(
                        "โอเค",
                        style: TextStyle(
                          fontFamily: "Jasmine",
                          color: Color(0xFF707070),
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFE5EFC1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signin_Screen()),
                        );
                      },
                    ),
                  ],
                )
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text(
                  'ไม่พบผู้ใช้สำหรับอีเมลนี้ !',
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(
                          "โอเค",
                          style: TextStyle(
                            fontFamily: "Jasmine",
                            color: Color(0xFF707070),
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFE5EFC1),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                      ),
                    ],
                  )
                ],
              );
            });
      }
    }
    }
    else{
      showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text(
                  'อีเมลไม่ถูกต้อง กรุณากรอกใหม่อีกครั้ง',
                  style: TextStyle(
                    fontFamily: "Jasmine",
                    color: Color(0xFF707070),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(
                          "โอเค",
                          style: TextStyle(
                            fontFamily: "Jasmine",
                            color: Color(0xFF707070),
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFE5EFC1),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                      ),
                    ],
                  )
                ],
              );
            });
    }
    
  }

  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("validate");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signin_Screen()),
      );
    } else {
      print("not validate");
    }
  }

  Widget NewPassword() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.trim().length == 0) {
                return "กรุณาระบุข้อมูล";
              }
              if (!RegExp(
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                  .hasMatch(value)) {
                return "กรุณากรอกอีเมลให้ถูกต้อง";
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: "name@example.com",
                labelText: "อีเมล",
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

  Widget Button() {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                email = emailController.text;
              });
              resetPassword();
            }
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
                "เปลี่ยนรหัสผ่าน",
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
                  SizedBox(
                    height: 30.0,
                  ),
                  NewPassword(),
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
