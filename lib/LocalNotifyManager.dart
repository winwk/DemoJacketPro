import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:jackket/Profilepage.dart';
import 'package:rxdart/rxdart.dart';

class LocalNotifyManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;
  var noti;
  var date;
  var noti02;
  var date02;

  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();
  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  initializePlatform() {
    var initSettingAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    var initSettingIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification =
              ReceiveNotification(id: id, title: '', body: '', payload: '');
          didReceiveLocalNotificationSubject.add(notification);
        });
    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String? payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> showNotification() async {
    final db = FirebaseDatabase.instance.reference().child("Jacket01/notinow");
    final db02 =
        FirebaseDatabase.instance.reference().child("Jacket02/notinow");

    var jackName;
    var jackName02;
    var checkJackName;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("test")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      jackName = value.data()!['JacketName'][0];
      jackName02 = value.data()!['JacketName'][1];
      checkJackName = value.data()!['JacketName'];
    });
    print("jacketName = $jackName");
    print("jacketName02 =$jackName02");
    print("chckJacketName =$checkJackName");
    var androidChannel = AndroidNotificationDetails(
        'Channel_ID', 'Channel_NAME', 'Channel_DESCRIPTION',
        importance: Importance.max, priority: Priority.high, playSound: true);
    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
        
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) async {
        noti = values['title'];
        date = values['datetime'];
        print("noti = $noti");
        if (noti == null || noti == "") {
          return null;
        } else {
          await flutterLocalNotificationsPlugin.show(
              0, '$noti', '$date', platformChannel,
              payload: 'NEW payload');
        }
      });
    });
    // var androidChannel = AndroidNotificationDetails(
    //     'Channel_ID', 'Channel_NAME', 'Channel_DESCRIPTION',
    //     importance: Importance.max, priority: Priority.high, playSound: true);
    // var iosChannel = IOSNotificationDetails();
    // var platformChannel =
    //     NotificationDetails(android: androidChannel, iOS: iosChannel);
    // await flutterLocalNotificationsPlugin
    //     .show(0, '$jackName', 'testbody', platformChannel, payload: 'NEW payload');
  }
}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();

class ReceiveNotification {
  late final int id;
  late final String title;
  late final String body;
  late final String payload;
  ReceiveNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}
