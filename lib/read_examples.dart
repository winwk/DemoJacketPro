import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class read extends StatefulWidget {
  read({Key? key}) : super(key: key);

  @override
  _readState createState() => _readState();
}

class _readState extends State<read> {

  final _database = FirebaseDatabase.instance.reference();
  var showVideo;
  var showdate;
  final db = FirebaseDatabase.instance.reference().child("Jacket01/video");

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
              query: db,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                db.once().then((DataSnapshot snapshot) {
                  Map<dynamic, dynamic> values = snapshot.value;
                  values.forEach((key, values) {
                    // print(values["videoUrl"]);
                    setState(() {
                    showVideo = values["videoUrl"];
                    showdate = values["datetime"];
                    print(showVideo);
                    });
                    
                  });
                });
                return SizedBox(
                  width: 355,
                  height: 130,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                        title: Text(showdate+'\n'),
                        subtitle: Linkify(
                          text: showVideo,
                          onOpen: _onOpen,
                        )),
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