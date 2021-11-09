import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class noti extends StatefulWidget {
  noti({Key? key}) : super(key: key);

  @override
  _notiState createState() => _notiState();
}

class _notiState extends State<noti> {
  late Future<void> _launched;
  var datevideo;
  var video;
  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  final db = FirebaseDatabase.instance
      .reference()
      .child("Jacket01/noti")
      .orderByChild("timestamp");
  final dbvideo = FirebaseDatabase.instance.reference().child("Jacket01/video");
  late final bool reverse;

  _checkvideo() {
    dbvideo.once().then((DataSnapshot snapshotvideo) {
      Map<dynamic, dynamic> values = snapshotvideo.value;
      values.forEach((key, values) {
        //video = snapshotvideo.value['videoUrl'];
        // datevideo = snapshotvideo.value['datetime'];
        datevideo = values['datetime'];
        //video = values['videoUrl'];
        //snapshotvideo.value.toList()[datevideo]["datetime"];
      });
      //print(snapshotvideo.value);
    });
  }

  @override
  void initState() {
    super.initState();
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {});
      //print(snapshot.value['datetime']);
    });
    _checkvideo();
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
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel_rounded,
                        size: 42, color: Colors.white),
                  ),
                )
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              centerTitle: true,
              backgroundColor: Color(0xff39AEA9),
              title: Column(children: [
                box(),
                Text(
                  "การแจ้งเตือน",
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
              padding: const EdgeInsets.all(8.0),
              child: FirebaseAnimatedList(
                physics: BouncingScrollPhysics(),
                query: db,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return SizedBox(
                      width: 355,
                      height: 90,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: ListTile(
                            title: new Text(snapshot.value['title']),
                            subtitle: snapshot.value['lat'] == null
                                ? Text(
                                    "วันเวลา : " + snapshot.value['datetime'])
                                : Text("Latitude : " +
                                    snapshot.value['lat'] +
                                    "  Longtitude : " +
                                    snapshot.value['lng'] +
                                    "\n" +
                                    "วันเวลา : " +
                                    snapshot.value['datetime']),
                            leading: snapshot.value['title'] == "SOS!!!"
                                ? Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.red[200],
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.location_pin,
                                    color: Colors.green[200],
                                    size: 40,
                                  ),
                            onTap: snapshot.value['video'] != null
                                ? () {
                                    _launchInApp(snapshot.value['video']);
                                  }
                                : () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            title: Text(
                                              'ไม่พบวิดีโอ',
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
                                                  ElevatedButton(
                                                    child: Text(
                                                      "ตกลง",
                                                      style: TextStyle(
                                                        fontFamily: "Jasmine",
                                                        color:
                                                            Color(0xFF707070),
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Color(0xFFE5EFC1),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                          ),
                        ),
                      ));
                },
              ),
            ),
          )),
    );
  }
}
