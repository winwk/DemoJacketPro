import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String profileImage;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.profileImage,
  });

  // data from server parsing
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      profileImage: map['profileImage'],
    );
  }
  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profileImage': profileImage,
    };
  }
}