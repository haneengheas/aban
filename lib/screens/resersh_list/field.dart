// ignore_for_file: use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FieldListresersh extends StatefulWidget {
  const FieldListresersh({required this.userId});
  final String? userId;
  @override
  State<FieldListresersh> createState() => _FieldListresershState();
}

class _FieldListresershState extends State<FieldListresersh> {
  getData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    debugPrint('userType is ${documentSnapshot.get('fields')}');

    setState(() {});
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("member")
            .where('userId', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const SizedBox()
                //TODO: show loading
                : ListView.builder(
                    itemCount: snapshot.data!.docs[0]['fields'].length,
                    itemBuilder: (context, index) {
                      return snapshot.data!.docs[0]['fields'].isEmpty
                          ? const SizedBox()
                          : Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 10,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  snapshot.data!.docs[0]['fields'][index],
                                  style: hintStyle,
                                )
                              ],
                            );
                    },
                  );
          }
          return const SizedBox();
        });
  }
}

List fields = [
  'المجال الاول',
  'المجال الثاني',
  'المجال الثالث',
  'المجال الرابع',
  'المجال الخامس',
  'المجال السادس',
];
