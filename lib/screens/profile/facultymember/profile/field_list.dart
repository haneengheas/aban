import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FieldList extends StatefulWidget {
  const FieldList({Key? key}) : super(key: key);

  @override
  State<FieldList> createState() => _FieldListState();
}

class _FieldListState extends State<FieldList> {
  @override
  Widget build(BuildContext context) {
    // var fields= FirebaseFirestore.instance.collection("member").get();
    // List fieldslist = fields.then((value) => null) as List;

    // List pointList = [];
    // getdata() async {
    //   await FirebaseFirestore.instance
    //       .collection("member")
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .get()
    //       .then((value) {
    //     setState(() {
    //       // first add the data to the Offset object
    //       List.from(value.data['fields']).forEach((element) {
    //         Offset data = Offset(element);
    //         pointList.add(data);
    //       });
    //     });});}

    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("member").get(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    snapshot.data!.docs[0]['fields'],
                    style: hintStyle,
                  )
                ],
              );
            },
          );
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
