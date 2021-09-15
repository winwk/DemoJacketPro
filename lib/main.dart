import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jackket/Addlocation.dart';
import 'package:jackket/ChangeProJacket.dart';
import 'package:jackket/Homepage.dart';
import 'package:jackket/JacketProfile.dart';
import 'package:jackket/Jacketpage.dart';
import 'package:jackket/Locationpage.dart';
import 'package:jackket/Profilepage.dart';
import 'package:jackket/changeProfile.dart';
import 'package:jackket/changepassword.dart';
import 'package:jackket/home.dart';
import 'package:jackket/home1.dart';
import 'package:jackket/register.dart';
import 'package:jackket/login.dart';
import 'package:jackket/manual.dart';
import 'package:jackket/Videopage.dart';
import 'package:jackket/router.dart';

String initialRoute = '/home';
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initialRoute = '/home1';
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
     initialRoute: initialRoute,
    );
  }
}
