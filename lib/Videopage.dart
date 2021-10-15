import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final _database = FirebaseDatabase.instance.reference();
  var showVideo;

  @override
  void initState() {
    super.initState();
    checkVideo();
  }


  void checkVideo() {
    _database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final video = data['video']as String;
      print(video);
      showVideo = video;
    });
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  Widget show(){
    return SizedBox(
      child: Card(
        
        child: Text(showVideo)),
    );
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
                "วิดีโอ",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Jasmine",
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold),
              ),
              show()
            ]),
          ),
        ),
        //body: ,
      ),
    );
  }
}
