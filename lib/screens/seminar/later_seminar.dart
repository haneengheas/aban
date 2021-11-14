import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/seminar_details.dart';
import 'package:aban/screens/seminar/seminar_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_seminar.dart';

class LaterSeminar extends StatefulWidget {
  LaterSeminar(this.filter, this.seminar, {Key? key}) : super(key: key);

  final List<SeminarModel> seminar;
  final String? filter;

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<LaterSeminar> {
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return  Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddSeminar()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'أضف ندوة  ',
                      style: hintStyle2,
                    ),
                    const Icon(
                      Icons.add_circle_outline,
                      color: blue,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.seminar.length,
                  itemBuilder: (context, index) {
                    return widget.filter == null || widget.filter == ""
                        ? _buildSeminarBox(
                            widget.seminar[index],
                          )
                        : widget.seminar[index].seminartitle!
                                    .toLowerCase()
                                    .contains(widget.filter!.toLowerCase()) ||
                                widget.seminar[index].seminartitle!
                                    .toLowerCase()
                                    .contains(widget.filter!.toLowerCase())
                            ? _buildSeminarBox(
                                widget.seminar[index],
                              )
                            : Container();
                  },
                ),
              ),
            ],
          );

  }
  Widget _buildSeminarBox(SeminarModel seminar) => InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SeminarDetails(
                description: seminar.discription,
                from: seminar.from,
                link: seminar.link,
                location: seminar.location,
                selectday: seminar.selectday,
                seminarname: seminar.seminartitle,
                to: seminar.to,
                type: seminar.type,
                userid: seminar.userid,
                username: seminar.username,
              )));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: sizeFromWidth(context, 1),
      height: 125,
      decoration: BoxDecoration(
        color: clearblue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      seminar.seminartitle!,
                      style: labelStyle2,
                    ),
                    SizedBox(
                      width: sizeFromWidth(context, 5),
                    ),
                    Text(
                      // snapshot.data!.docs[index]
                      // ['selectedDay'].toString(),
                      '9999999',
                      style: hintStyle3,
                    ),
                    const Icon(
                      Icons.date_range,
                      color: blue,
                      size: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                 seminar.username!,
                  style: hintStyle3,
                ),
              ],
            ),
            const VerticalDivider(
              color: gray,
              endIndent: 10,
              indent: 10,
              width: 5,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      seminar.type == 1
                          ? 'عامة'
                          : 'خاصة',
                      style: labelStyle3,
                    ),
                    // InkWell(
// onTap: () {
// setState(() {
// checked = !checked;
// });
// },
// child: Container(
// height: 40,
// width: 25,
// margin: const EdgeInsets.symmetric(
// vertical: 10),
// child: checked
// ? const ImageIcon(
// AssetImage(
// 'assets/bookmark (1).png',
// ),
// color: blue,
// size: 50,
// )
// : const ImageIcon(
// AssetImage(
// 'assets/bookmark (2).png',
// ),
// color: blue,
// size: 50,
// ),
// ),
// ),
                  ]),
            ),
          ],
        ),
      ),
    ),
  );


}


