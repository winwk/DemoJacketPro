import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jackket/Addlocation.dart';
import 'package:page_transition/page_transition.dart';

class LocationPage extends StatefulWidget {
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final db = FirebaseDatabase.instance.reference().child("Jacket01/savelocate");
  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  @override
  void initState() {
    super.initState();
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {});
    });
  }

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
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: AddLocationPage()),
                    );
                  },
                  child: Icon(Icons.add_circle_rounded,
                      size: 42, color: Colors.white),
                ),
              )
            ],
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
                "สถานที่ที่บันทึกไว้",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Jasmine",
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FirebaseAnimatedList(
              query: db,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return SizedBox(
                  width: 300,
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: ListTile(
                        title: new Text(snapshot.value['title']),
                        subtitle: Text('Latitude = ' +
                            snapshot.value['lat'].toString() +
                            '\nLongtitude = ' +
                            snapshot.value['lng'].toString()),
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
                                        'ลบสถานที่',
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
          ),
        ),
      ),
    );
  }
}

_delete(var key) async {
  final db = FirebaseDatabase.instance.reference().child("Jacket01/savelocate");
  await db.child(key).remove();
}
