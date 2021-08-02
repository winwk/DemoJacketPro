import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jackket/home1.dart';

class signin_Screen extends StatefulWidget {
  static String route = "sign_SC";

  @override
  _signin_ScreenState createState() => _signin_ScreenState();
}

class _signin_ScreenState extends State<signin_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nameString, emailString, passwordString, confirmpassString;
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("validate");
    } else {
      print("not validate");
    }
  }

  Widget box() {
    return SizedBox(
      height: 20,
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
                    return "กรุณากรอกอีเมลให้ถูกต้อง";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  emailString = value;
                })
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
                controller: _password,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "กรอกรหัสผ่านของคุณ...",
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
                  if (value.length < 6) {
                    return "รหัสผ่านไม่ควรน้อยกว่า 6 ตัวอักษร";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  passwordString = value;
                })
          ],
        ),
      ),
    );
  }

  Widget loginButton2() {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            print("You Click upload");
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();
              print("email = $emailString, password = $passwordString");
              try {
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailString!, password: passwordString!)
                    .then((value) {
                  _formKey.currentState?.reset();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return home1();
                  }));
                });
              } on FirebaseAuthException catch (e) {
                print(e.code);
                String message = "";
                if (e.code == "user-not-found") {
                  message = "ไม่พบผู้ใช้นี้ในระบบ";
                }
                if (e.code == "wrong-password") {
                  message = "รหัสผ่านไม่ถูกต้อง";
                }
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        title: Text(
                          message,
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
                                  "ตกลง",
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
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
          },
          child: Text(
            "เข้าสู่ระบบ",
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
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                        "เข้าสู่ระบบ",
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
                          buildEmail(),
                          SizedBox(
                            height: 20.0,
                          ),
                          buildPassword(),
                          SizedBox(
                            height: 20.0,
                          ),
                          loginButton2()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
