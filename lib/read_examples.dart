import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReadExamples extends StatefulWidget {
  ReadExamples({Key? key}) : super(key: key);

  @override
  _ReadExamplesState createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {
  final _database = FirebaseDatabase.instance.reference();
  var _displayText = "test";
  late StreamSubscription _videoStream;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }


  void _activateListeners() {
    _database.child('Jacket01').onValue.listen((event) {
      final data = new Map<String, dynamic>.from(event.snapshot.value);
      final pass = data['pass'] as String;
      final video = data['video'];
      print(video);
      _displayText = video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read exam'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [Text(_displayText)],
          ),
        ),
      ),
    );
  }
}
