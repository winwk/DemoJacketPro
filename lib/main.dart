import 'package:flutter/material.dart';
import 'package:jackket/home.dart';
import 'package:jackket/register.dart';
import 'usermanual.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home(),
      routes: {
        userMan.route: (context) => userMan(),
        Register_Screen.route: (context) => Register_Screen()
      },
      
    );
  }
}


