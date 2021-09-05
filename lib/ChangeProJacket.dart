
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jackket/JacketProfile.dart';

class ChangeProJacket extends StatefulWidget {
  @override
  _ChangeProJacketState createState() => _ChangeProJacketState();
}

class _ChangeProJacketState extends State<ChangeProJacket> {
 File? image;

  final picker = ImagePicker();
  //generated_plugin_registrant.dart Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if(pickedImage != null){
      setState(() {
        image = File(pickedImage.path);
      });
    }
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
                  labelText: "ชื่อผู้ใช้",
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

  Widget Button() {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              SizedBox(height: 35),
              Container(
                width: 150,
                height: 150,
                color: Colors.grey,
                child: image != null
                    ? Image.file(image!, fit: BoxFit.cover)
                    : Text(''),
              ),
              
              Center(
                child: ElevatedButton(
          onPressed: () {
            _openImagePicker();
          },
          child: Text(
            "เลือกรูปภาพ",
            style: TextStyle(
                fontFamily: "Jasmine",
                color: Color(0xFF707070),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFE5EFC1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        )
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  username(),
                  SizedBox(
                    height: 20,
                  ),
                  Button(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ]),
          ),
        ),
        
      ),
    );
  }
}