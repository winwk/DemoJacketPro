import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jackket/Profilepage.dart';
import 'package:jackket/home1.dart';
import 'dart:io';

import 'package:path/path.dart' as p;

class ChangeProfile extends StatefulWidget {
  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String? nameString;
  File? file;

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
                  icon: Icon(Icons.face),
                  labelText: "ชื่อผู้ใช้",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
              validator: (String? value) {
                if (value == null || value.trim().length == 0) {
                  return "กรุณาระบุข้อมูล";
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

  Widget Button() {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();
              print("###$nameString");
              await Firebase.initializeApp().then((value) async {
                await FirebaseAuth.instance
                    .authStateChanges()
                    .listen((event) async {
                  event?.updateProfile(displayName: nameString);
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        title: Text(
                          'แก้ไขโปรเสร็จสิ้น',
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
    Map<String, dynamic> map = Map();
    if (file != null) {
      String url = await uploadImage();
      map['profileImage'] = url;
    }

    await FirebaseFirestore.instance
        .collection("test")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(FirebaseAuth.instance.currentUser!.uid +
            "_" +
            p.basename(file!.path))
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }
}
