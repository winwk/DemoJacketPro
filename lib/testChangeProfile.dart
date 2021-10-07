import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jackket/home1.dart';
import 'package:path/path.dart';

class testChangeProfile extends StatefulWidget {
  testChangeProfile({Key? key}) : super(key: key);

  @override
  _testChangeProfileState createState() => _testChangeProfileState();
}

class _testChangeProfileState extends State<testChangeProfile> {
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editprofile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                file == null
                    ? CircleAvatar(
                      child: InkWell(
                          onTap: () {
                            chooseImage();
                          },
                          child: Icon(
                            Icons.image,
                            size: 35,
                          ),
                        ),
                    )
                    : Image.file(file!),
                SizedBox(
                  height: 30,
                ),
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onPressed: () {
                    updateProfile();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => home1()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
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

  updateProfile() async {
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
        .child(
            FirebaseAuth.instance.currentUser!.uid + "_" + basename(file!.path))
        .putFile(file!);

    return taskSnapshot.ref.getDownloadURL();
  }
}
