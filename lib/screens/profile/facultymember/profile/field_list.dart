import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class FieldList extends StatelessWidget {
  const FieldList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection("member").get(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index){
            return Row(
              children: [
                const Icon(Icons.circle,size: 10,) ,
                const SizedBox(
                  width: 10,
                ),
                Text(fields[index],style: hintStyle,)
              ],
            );
          },
        );
      }
    );
  }
}
List fields=[
  'المجال الاول',
  'المجال الثاني',
  'المجال الثالث',
  'المجال الرابع',
  'المجال الخامس',
  'المجال السادس',

];