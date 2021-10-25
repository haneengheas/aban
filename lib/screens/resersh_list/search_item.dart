import 'package:aban/constant/style.dart';
import 'package:aban/screens/profile/facultymember/overview_profile/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({Key? key}) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){

          // Navigator.push(context, MaterialPageRoute(builder: (context)=>GraduatedProfile()));
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const MemberProfile()));

        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:clearblue ),
          height: sizeFromHeight(context, 6),
          width: sizeFromWidth(context, 1.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image:const AssetImage(
                    'assets/user.png',
                  ),
                  height: sizeFromHeight(context, 13),
                  color: blue,
                ),
                SizedBox(
                  width: sizeFromWidth(context, 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'اسم الباحث',
                      style: hintStyle4,
                    ),
                    const Divider(
                      thickness: 1,
                      color: gray,
                      height: 1.5,
                    ),
                    Text(
                      'Reserch@email.com \n الدرجة العلمية',
                      style: hintStyle2,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
