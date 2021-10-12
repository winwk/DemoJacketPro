import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jackket/user/user_model.dart';

class showListUsers extends StatefulWidget {
  const showListUsers({Key? key}) : super(key: key);

  @override
  _showListUsersState createState() => _showListUsersState();
}

class _showListUsersState extends State<showListUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "users",
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("test").get().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length == 0) {
                return Text("No users");
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserModel userModel =
                        UserModel.fromMap(snapshot.data!.docs[index].data());
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(userModel.profileImage),
                        ),
                        title: Text(userModel.name),
                      ),
                    );
                  });
            }

            return CircularProgressIndicator();
          }),
    );
  }
}
