import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class notitest extends StatefulWidget {
  notitest({Key? key}) : super(key: key);

  @override
  _notitestState createState() => _notitestState();
}

class _notitestState extends State<notitest> {

  var Token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noti'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                String? token = await FirebaseMessaging.instance.getToken();
                print(token);
                Token = token;
              },
              child: Text(Token),
            )
          ],
        ),
      ),
    );
  }
}
