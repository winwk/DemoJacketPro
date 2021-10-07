import 'package:cloud_firestore/cloud_firestore.dart';


class ReviewService {
  getLatestReview(String email,String uid){
    return FirebaseFirestore.instance.
    collection('test')
    .where('email', isEqualTo: email)
    .where('uid', isEqualTo: uid)
    .get();
  }
}