import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class FieldList extends StatefulWidget {
  const FieldList({Key? key}) : super(key: key);

  @override
  State<FieldList> createState() => _FieldListState();
}

class _FieldListState extends State<FieldList> {
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
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
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
