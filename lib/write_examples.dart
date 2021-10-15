import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteExamples extends StatefulWidget {
  WriteExamples({Key? key}) : super(key: key);

  @override
  _WriteExamplesState createState() => _WriteExamplesState();
}

class _WriteExamplesState extends State<WriteExamples> {
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    final testtestRef = database.child('/testtest');
    return Scaffold(
      appBar: AppBar(
        title: Text('write exam'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await testtestRef
                      .update({'update': 'testUpdate'}).catchError(
                          (error) => print('You got error $error'));
                  print("has been");
                },
                child: Text('set'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
