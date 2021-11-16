import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/edit_seminar.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeminarDetails extends StatelessWidget {
  String? seminarname,
      username,
      location,
      description,
      from,
      to,
      link,
      userid,
      docid;
  var type, selectday;
  bool? isFav;

  SeminarDetails(
      {Key? key,
      this.type,
      this.selectday,
      this.userid,
      this.from,
      this.to,
      this.link,
      this.docid,
      this.isFav,
      this.description,
      this.location,
      this.seminarname,
      this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: customAppBar(context, title: 'ندوة'),
          preferredSize: const Size.fromHeight(50)),
      body: Column(
        children: [
          Container(
            height: 240,
            width: sizeFromWidth(context, 1),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: clearblue,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: clearblue),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$seminarname',
                                  style: labelStyle3,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      // snapshot.data!.docs[index]
                                      // ['selectedDay'].toString(),
                                      '29/5/2021',
                                      style: hintStyle3,
                                    ),
                                    const Icon(
                                      Icons.date_range,
                                      color: blue,
                                      size: 20,
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '$to',
                                  style: hintStyle3,
                                ),
                                Text(
                                  ':' + '$from' + 'pm',
                                  style: hintStyle3,
                                ),
                              ],
                            ),
                            Text(
                              '$username',
                              style: hintStyle3,
                            ),
                            Text(
                              '$location',
                              style: hintStyle3,
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: gray,
                        endIndent: 10,
                        indent: 20,
                        width: 20,
                        thickness: 5,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              type == 1 ? 'عامة' : 'خاصة',
                              style: labelStyle3,
                            ),
                            Container(
                              height: 40,
                              width: 25,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: isFav == true
                                  ? const ImageIcon(
                                      AssetImage(
                                        'assets/bookmark (2).png',
                                      ),
                                      color: blue,
                                      size: 50,
                                    )
                                  : const ImageIcon(
                                      AssetImage(
                                        'assets/bookmark (1).png',
                                      ),
                                      color: blue,
                                      size: 50,
                                    ),
                            )
                          ]),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'وصف الندوة',
                    style: labelStyle3,
                  ),
                  Expanded(
                    child: Text(
                      '$description',
                      style: hintStyle3,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print(docid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditSeminar(
                                    docId: docid,
                                    username: username,
                                    isFav: isFav,
                                    userid: userid,
                                    description: description,
                                    from: from,
                                    link: link,
                                    location: location,
                                    selectday: selectday,
                                    seminarname: seminarname,
                                    to: to,
                                    type: type,
                                  )));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit,
                          color: blue,
                          size: 15,
                        ),
                        Text(
                          'تعديل ندوة',
                          style: hintStyle3,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
