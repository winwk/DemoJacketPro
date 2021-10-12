import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jackket/AddPassDevice.dart';
import 'package:jackket/user/showListofUsers.dart';
import 'package:jackket/user/user_model.dart';
import 'package:page_transition/page_transition.dart';

class AddDevice extends StatefulWidget {
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("test");
  CollectionReference _jackCollection =
      FirebaseFirestore.instance.collection("Jacket01");
  var deviceName01 = "Jacket01";
  var deviceName02 = "Jacket02";
  String? nameString;

  @override
  void initState() {
    super.initState();
  }

  void onPressed() {
    _jackCollection.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        _jackCollection
            .doc(result.id)
            .collection("noti")
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            print(result.data());
          });
        });
      });
    });
  }

  void _onPressed() {
    FirebaseFirestore.instance
        .collection("Jacket01")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  void updateJack() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .update({"JacketName": nameString}).then((_) {
      print("success!");
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

  Widget addButton() {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          print('####you click addDevice###');
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();
            updateProfile(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return addPassDevice2();
            }));
          }
          print("###$nameString");
        },
        child: Text(
          "ถัดไป",
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
                if (value != deviceName01 && value != deviceName02) {
                  return "ชื่ออุปกรณ์ไม่ถูกต้อง";
                } else {
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
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              buildUserName(),
              SizedBox(
                height: 50,
              ),
              addButton(),
            ],
          ),
        ),
        //body: ,
      ),
    );
  }

  updateProfile(BuildContext context) async {
    Map<String, dynamic> map = Map();
    if (nameString != null) {
      map['JacketName'] = nameString;
    }

    await FirebaseFirestore.instance
        .collection("test")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
  }
}
