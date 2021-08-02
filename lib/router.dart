import 'package:flutter/material.dart';
import 'package:jackket/home.dart';
import 'package:jackket/home1.dart';


final Map<String, WidgetBuilder> routes ={
  '/home': (BuildContext context) => home(),
  '/home1': (BuildContext context) => home1()
};