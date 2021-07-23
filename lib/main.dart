import 'package:flutter/material.dart';
import 'package:jackket/Homepage.dart';
import 'package:jackket/JacketProfile.dart';
import 'package:jackket/Jacketpage.dart';
import 'package:jackket/Profilepage.dart';
import 'package:jackket/changepassword.dart';
import 'package:jackket/home.dart';
import 'package:jackket/home1.dart';
import 'package:jackket/register.dart';
import 'package:jackket/login.dart';
import 'package:jackket/manual.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home1(),
      routes: {
        Register_Screen.route: (context) => Register_Screen(),
      },
    );
  }
}
