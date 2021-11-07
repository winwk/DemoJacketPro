import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPage extends StatefulWidget {
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final _database = FirebaseDatabase.instance.reference();
  var showVideo;
  var showdate;
  final db = FirebaseDatabase.instance
      .reference()
      .child("Jacket01/video")
      .orderByChild("timestamp");

  @override
  void initState() {
    super.initState();
    // checkVideo();
    // db = FirebaseDatabase.instance.reference().child("Jacket01/video");

    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        // print(values["videoUrl"]);
      });
      //print(showVideo);
    });
  }

  // static Future<Query> queryUsers() async {
  //   return FirebaseDatabase.instance
  //       .reference()
  //       .child("Jacket01")
  //       .child('video')
  //       .orderByChild('name');
  // }

  void checkVideo() {
    _database.child('Jacket01').child("video").onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final video = data;
      print(video);
    });
  }

  Widget box() {
    return SizedBox(
      height: 20,
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
              ]),
            ),
          ),
          body: SafeArea(
            child: FirebaseAnimatedList(
              //shrinkWrap: true,
              //reverse: true,
              query: db,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return SizedBox(
                  width: 355,
                  height: 130,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: ListTile(
                        title: new Text(snapshot.value['datetime']),
                        subtitle: Linkify(
                          text: snapshot.value['videoUrl'],
                          onOpen: _onOpen,
                        ),
                        leading: Icon(
                          Icons.slideshow,
                          color: Colors.green[200],
                          size: 40,
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      title: Text(
                                        'ลบวิดีโอ',
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: ElevatedButton(
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
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                ),
                                                onPressed: () {
                                                  var key = snapshot.key;
                                                  print(key);
                                                  _delete(key);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            ElevatedButton(
                                              child: Text(
                                                "ยกเลิก",
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
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw ('cannot open link $link');
    }
  }
}

_delete(var key) async {
  final db = FirebaseDatabase.instance.reference().child("Jacket01/video");
  await db.child(key).remove();
}
