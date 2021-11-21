// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class SeminarModel {
  String? seminartitle,
      username,
      location,
      discription,
      link,
      userid,
      from,
      to,
  dropdown,
  dropdown2,
      docId;
  Timestamp? selectday;
  int? type;
  bool ?isFav;

  SeminarModel(
      {this.location,
        this.dropdown,
        this.dropdown2,
      this.to,
      this.link,
      this.from,
      this.type,
      this.isFav,
      this.discription,
      this.username,
      this.selectday,
      this.docId,
      this.seminartitle,
      this.userid});
}
