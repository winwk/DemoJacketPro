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
  var jackId;

  final _database = FirebaseDatabase.instance.reference();

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

  final db02 = FirebaseDatabase.instance
      .reference()
      .child("Jacket02/noti")
      .orderByChild("timestamp");

  late final bool reverse;

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
    checknoti();

    // db.once().then((DataSnapshot snapshot) {
    //   Map<dynamic, dynamic> values = snapshot.value;
    //   values.forEach((key, values) {});
    //   //print(snapshot.value['datetime']);
    // });
    // _checkvideo();
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  checknoti() {
    if (jackId == "Jacket01") {
      return SafeArea(
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
                            ? Text("วันเวลา : " + snapshot.value['datetime'])
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
                                        'ลบการแจ้งเตือน',
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
                      ),
                    ),
                  ));
            },
          ),
        ),
      );
    }
    if (jackId == "Jacket02") {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FirebaseAnimatedList(
            physics: BouncingScrollPhysics(),
            query: db02,
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
                            ? Text("วันเวลา : " + snapshot.value['datetime'])
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
                                        'ลบการแจ้งเตือน',
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
                      ),
                    ),
                  ));
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xFF557B83),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 8),
                  child: IconButton(
                    icon: Icon(Icons.cancel_rounded,
                        size: 42, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
              automaticallyImplyLeading: true,
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
          body: checknoti()),
    );
  }

  _delete(var key) async {
    final db = FirebaseDatabase.instance.reference().child("$jackId/noti");
    await db.child(key).remove();
  }
}
