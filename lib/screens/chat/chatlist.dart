import 'package:cloud_firestore/cloud_firestore.dart';

class Chatlist {
  String? name,  image, userId;

  Timestamp? time;
  Chatlist({this.name,this.userId, this.time,this.image,});
}