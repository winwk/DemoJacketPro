import 'package:flutter/material.dart';
import 'package:jackket/home.dart';
import 'package:jackket/home1.dart';
import 'package:jackket/manual.dart';
import 'package:jackket/register.dart';
import 'package:jackket/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Manual(),
      routes: {
        Register_Screen.route: (context) => Register_Screen(),
      },
    );
  }
}
