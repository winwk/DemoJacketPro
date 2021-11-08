import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jackket/JacketProfile.dart';
import 'package:jackket/home1.dart';

class EditDevice extends StatefulWidget {
  @override
  _EditDeviceState createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _database = FirebaseDatabase.instance.reference();
  final database = FirebaseDatabase.instance.reference();

  String? currentpasswordJack;
  String? currentpassword;
  String? newPassword;
  String? confirmPassword;
  var jackId;

  @override
  void initState() {
    super.initState();
    _checkJacket();
  }

  _checkJacket() {
    _database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final sendJackID = data['sendJackID'];
      setState(() {
        jackId = sendJackID;
      });
      
    });
    
  }

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

  Widget buildPassword() {
    _database.child('$jackId').onValue.listen((event) {
      final data02 = new Map<String, dynamic>.from(event.snapshot.value);
      final pass = data02['pass'];
      // print(pass);
      currentpasswordJack = pass;
      print(currentpasswordJack);
    });
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
                if (value != currentpasswordJack) {
                  return "รหัสผ่านผิด กรุณากรอกใหม่อีกครั้ง";
                }
                return null;
              },
              onSaved: (String? value) {
                currentpassword = value;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget newPasswordField() {
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
            onSaved: (String? value) {
              newPassword = value;
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

  Widget confirmPasswordField() {
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
                if (value != _passwordController.text) {
                  return 'รหัสผ่านไม่ตรงกัน!';
                }
                return null;
              },
              onSaved: (String? value) {
                confirmPassword = value;
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
    final Jacket01Ref = database.child('/$jackId');
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();
              Jacket01Ref.update({'pass': confirmPassword});
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Text(
                        'เปลี่ยนรหัสผ่านอุปกรณ์เสร็จสิ้น',
                        style: TextStyle(
                          fontFamily: "Jasmine",
                          color: Color(0xFF707070),
                          fontSize: 27.0,
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              onPressed: () {
                                _formKey.currentState?.reset();

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => home1()),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ],
                        )
                      ],
                    );
                  });
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
                "เปลี่ยนรหัสผ่านอุปกรณ์",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Jasmine",
                    fontSize: 50.0,
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
                  buildPassword(),
                  SizedBox(
                    height: 30.0,
                  ),
                  newPasswordField(),
                  SizedBox(
                    height: 30.0,
                  ),
                  confirmPasswordField(),
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
