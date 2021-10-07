import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jackket/services/reviews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class testUser extends StatefulWidget {
  testUser({Key? key}) : super(key: key);

  @override
  _testUserState createState() => _testUserState();
}

class _testUserState extends State<testUser> {
  bool reviewFlag = false;

  var reviews;

  @override
  void initState() {
    super.initState();
    ReviewService()
        .getLatestReview('888@gmail.com', 'c1iDP2fmBFb4D0iHOOvzqPyWPgN2')
        .then((QuerySnapshot docs) {
      if (docs.docs.isNotEmpty) {
        reviewFlag = true;
        reviews = docs.docs[0].data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Material(
            elevation: 7.0,
            borderRadius: BorderRadius.circular(7.0),
            child: Container(
              height: 300.0,
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'test',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'test Review',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Row(
                    children: <Widget>[
                      reviewFlag
                          ? Row(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  reviews['profileImage']),fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      reviews['email'],
                                      style: TextStyle(fontSize: 14.0),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 25.0,
                                ),
                                Text(
                                  reviews['name'],
                                  style: TextStyle(fontSize: 14.0),
                                )
                              ],
                            )
                          : Text('Loading .......')
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
