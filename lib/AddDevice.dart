import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jackket/home1.dart';
import 'package:jackket/user/showListofUsers.dart';
import 'package:jackket/user/user_model.dart';
import 'package:page_transition/page_transition.dart';

class AddDevice extends StatefulWidget {
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _database = FirebaseDatabase.instance.reference();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("test");
  CollectionReference _jackCollection =
      FirebaseFirestore.instance.collection("Jacket01");
  String deviceName01 = "Jacket01";
  String deviceName02 = "Jacket02";
  TextEditingController _device = TextEditingController();

  TextEditingController _password = TextEditingController();
  String? passwordString;
  String? password;
  String? password02;

  String? nameString;
  var jackId;
var jackName;
  var jackName02;
  var checkJackName;
  @override
  void initState() {
    super.initState();
    _database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final sendJackID = data['sendJackID'];
      setState(() {
        jackId = sendJackID;
      });
    });
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("validate");
    } else {
      print("not validate");
    }
  }

  Widget buildUserName() {
     var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      setState(() {
        jackName = value.data()!['JacketName'][0];
        jackName02 = value.data()!['JacketName'][1];
        checkJackName = value.data()!['JacketName'];
      });
    });
    print("jacketName = $jackName");
    print("jacketName02 =$jackName02");
    print("chckJacketName =$checkJackName");
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _device,
              decoration: InputDecoration(
                  icon: Icon(Icons.face),
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
                if (value != deviceName01) {
                  if (value != deviceName02) {
                    return "ชื่ออุปกรณ์ไม่ถูกต้อง";
                  }
                }
                if (value == jackName || value == jackName02) {
                  return "คุณเพิ่มอุปกรณ์นี้ไปแล้ว";
                }
                
                 else {
                  return null;
                }
              },
              onSaved: (String? value) {
                nameString = value;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget Password() {
    _database.child(_device.text).onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final pass = data['pass'] as String;
      password = pass;
      print(password);
    });
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
                  if (value != password) {
                    return "รหัสผ่านผิด กรุณากรอกใหม่";
                  } else
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

  Widget addButton() {
   
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          print('####you click addDevice###');
          
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();
            print(nameString);
            updateProfile(context);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text(
                      'เพิ่มอุปกรณ์เสร็จสิ้น',
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
          "เพิ่มอุปกรณ์",
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
      ),
    );
  }

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
                child:
                    Icon(Icons.cancel_rounded, size: 42, color: Colors.white),
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
                "เพิ่มอุปกรณ์",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Jasmine",
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                buildUserName(),
                SizedBox(
                  height: 50,
                ),
                Password(),
                SizedBox(
                  height: 50,
                ),
                addButton(),
              ],
            ),
          ),
        ),
        //body: ,
      ),
    );
  }

  updateProfile(BuildContext context) async {
    var val = [];
    Map<String, dynamic> map = Map();
    if (nameString != null) {
      val.add(nameString);
    }

    await FirebaseFirestore.instance
        .collection("test")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"JacketName": FieldValue.arrayUnion(val)});

    //  await FirebaseFirestore.instance
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .collection("test")
    //       .add(map);
  }
}
