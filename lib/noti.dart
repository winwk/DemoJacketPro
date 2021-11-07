import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class noti extends StatefulWidget {
  noti({Key? key}) : super(key: key);

  @override
  _notiState createState() => _notiState();
}

class _notiState extends State<noti> {
  final db = FirebaseDatabase.instance.reference().child("Jacket01/noti");

  @override
  void initState() {
    super.initState();
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {});
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
            child: FirebaseAnimatedList(
              query: db,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return SizedBox(
                  width: 355,
                  height: 90,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      title: new Text(snapshot.value['data']),
                      subtitle: Text("\n" +
                          "วันเวลา : " +
                          snapshot.value['datetime'] 
                         ),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
