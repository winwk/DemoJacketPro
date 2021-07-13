import 'dart:js';

import 'package:flutter/material.dart';
import 'package:jackket/home.dart';
import 'package:jackket/manual.dart';
import 'package:jackket/register.dart';
import 'package:jackket/login.dart';

getRoutes() {
  return {
    home.route: (context) => home(),
    Register_Screen.route: (context) => Register_Screen(),
    signin_Screen.route: (context) => signin_Screen()
  };
}
