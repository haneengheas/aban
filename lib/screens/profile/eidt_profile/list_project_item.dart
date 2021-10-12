import 'package:aban/constant/style.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:flutter/material.dart';
class ListProjectItem extends StatefulWidget {
  @override
  State<ListProjectItem> createState() => _ListProjectItemState();
}

class _ListProjectItemState extends State<ListProjectItem> {
  bool widgetVisible = false ;

  void showWidget(){
    setState(() {
      widgetVisible =!widgetVisible ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: sizeFromWidth(context, 1.5),
            child: TextFieldUser(
                hintText: "المجال الاول",
                labelText: "المجالات:",
                scure: true)),
        Container(
          width: sizeFromWidth(context, 1.5),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35,),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.star,size: 5,color: Colors.red,),

                  hintText: 'المجال الثاني',
                  hintStyle: hintStyle,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ),
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(
                  Icons.add_circle_outline_sharp,
                  size: 15,

                ),
                onPressed: () {
                  showWidget();
                },
              ),
            ),
            Text(
              'إضافة مجال',
              style: hintStyle3,
            )
          ],
        ),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: widgetVisible,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              height: 30,
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'ادخل المجال',
                    hintStyle: hintStyle
                ),
              )
          ),
        ),
      ],
    );
  }
}
