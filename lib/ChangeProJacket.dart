import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jackket/home1.dart';
import 'package:path/path.dart' as p;

class ChangeProJacket extends StatefulWidget {
  @override
  _ChangeProJacketState createState() => _ChangeProJacketState();
}

class _ChangeProJacketState extends State<ChangeProJacket> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  CollectionReference _jackCollection =
      FirebaseFirestore.instance.collection("Jacket01");
  String? nameString;
  File? file;
    var jackId;

  final database = FirebaseDatabase.instance.reference();

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  @override
  void initState() {
    super.initState();
    database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final sendJackID = data['sendJackID'];
      //print(profileImage);
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

  // void updateNameJack() {
  //   FirebaseFirestore.instance
  //       .collection("Jacket01")
  //       .doc(_jackCollection.id)
  //       .update({"JacketName": nameString}).then((_) {
  //     print("success!");
  //   });
  // }

  Widget imageProfile() {
    return file == null
        ? InkWell(
            onTap: () {
              chooseImage();
            },
            child: CircleAvatar(
              radius: 55.0,
              backgroundImage: AssetImage("assets/person.png"),
              backgroundColor: Colors.white,
            ),
          )
        : ClipOval(
            child: Image.file(
              file!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          );
  }

  Widget username() {
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
              onSaved: (String? value) {
                nameString = value;
              },
            )
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
              database.child('$jackId').update({'user': nameString});
              // Jacket01Ref.update({'user': nameString});
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Text(
                        'แก้ไขโปรไฟล์แจ็คเก็ตเสร็จสิ้น',
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              onPressed: () {
                                _formKey.currentState?.reset();
                                updateProfile(context);
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
              Text(
                "แก้ไขโปรไฟล์",
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
                  box(),
                  imageProfile(),
                  SizedBox(
                    height: 50,
                  ),
                  username(),
                  SizedBox(
                    height: 50,
                  ),
                  Button(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    print("file" + xfile!.path);
    file = File(xfile.path);
    setState(() {});
  }

  updateProfile(BuildContext context) async {
    final Jacket01Ref = database.child('/$jackId');

    if (file != null) {
      String url = await uploadImage();
      database.child('$jackId').update({'imageProfile': url});
    }
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profileJacket")
        .child(FirebaseAuth.instance.currentUser!.uid +
            "_" +
            p.basename(file!.path))
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }
}
