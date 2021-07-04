import 'package:flutter/material.dart';
import 'package:jackket/home.dart';
import 'package:jackket/manual.dart';
import 'package:jackket/register.dart';

getRoutes(){
  return {
        home.route: (context) => home(),
        Register_Screen.route: (context) => Register_Screen()
  };
}