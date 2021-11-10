import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChangeDistance extends StatefulWidget {
  _ChangeDistanceState createState() => _ChangeDistanceState();
}

class _ChangeDistanceState extends State<ChangeDistance> {
  //double value = 0.4;

  final _database = FirebaseDatabase.instance.reference();

  double getdistance = 0.4;
  var jackId;

  @override
  void initState() {
    super.initState();
    _database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final sendJackID = data['sendJackID'];
      //print(profileImage);
      setState(() {
        jackId = sendJackID;
      });
      _database.child('$jackId').onValue.listen((event) {
        final data = new Map<dynamic, dynamic>.from(event.snapshot.value);
        final distance = data['distance'] as double;
        setState(() {
          getdistance = distance;
        });
      });
    });
  }

  void updatedistance() {
    _database.child('$jackId').update({'distance': getdistance});
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

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
                "ระยะการแจ้งเตือน",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Jasmine",
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text("ระยะการแจ้งเตือนของแจ็คเก็ต",
                    style: TextStyle(
                      fontFamily: "Jasmine",
                      color: Colors.white,
                      fontSize: 35.0,
                    )),
                SizedBox(
                  height: 20,
                ),
                Slider(
                    value: getdistance,
                    min: 0.3,
                    max: 0.5,
                    divisions: 2,
                    activeColor: Color(0xFFE5EFC1),
                    inactiveColor: Color(0xff39AEA9),
                    onChanged: (value) {
                      setState(() {
                        getdistance = value;
                      });
                      updatedistance();
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("1 เมตร",
                        style: TextStyle(
                          fontFamily: "Jasmine",
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    Text("1.5 เมตร",
                        style: TextStyle(
                          fontFamily: "Jasmine",
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    Text("2 เมตร",
                        style: TextStyle(
                          fontFamily: "Jasmine",
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
