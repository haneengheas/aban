import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class FieldList extends StatelessWidget {
  const FieldList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context,index){
        return Row(
          children: [
            Icon(Icons.circle,size: 10,) ,
            SizedBox(
              width: 10,
            ),
            Text(fields[index],style: hintStyle,)
          ],
        );
      },
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