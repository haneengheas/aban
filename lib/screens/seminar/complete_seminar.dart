import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/seminar_details.dart';
import 'package:aban/screens/seminar/seminar_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_seminar.dart';

class CompleteSeminar extends StatefulWidget {
  const CompleteSeminar(this.filter,this.seminar,{Key? key}) : super(key: key);

  final List<SeminarModel> seminar;
  final String? filter;

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<CompleteSeminar> {
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddSeminar()));
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
          child:
                ListView.builder(
                  itemCount: widget.seminar.length,
                  itemBuilder: (context, index) {
                    return widget.filter == null || widget.filter == ""
                        ? buildSeminarBox(
                      widget.seminar[index],
                    )
                        : widget.seminar[index].seminartitle!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase()) ||widget.seminar[index].seminartitle!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase())
                        ?
                    buildSeminarBox(
                      widget.seminar[index],
                    )
                        : Container();
                  },
                )

        ),
      ],
    );
  }
  Widget buildSeminarBox(SeminarModel seminar)=>InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  SeminarDetails(
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
              ))
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 5),
      width: sizeFromWidth(context, 1),
      height: 120,
      decoration: BoxDecoration(
        color: clearblue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
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
                       seminar.selectday.toString(),
                        style: hintStyle3,
                      ),
                      const Icon(
                        Icons.date_range,
                        color: blue,
                        size: 20,
                      )
                    ],
                  ),
                  Text(
                    '8:00-8:30pm',
                    style: hintStyle3,
                  ),
                  Text(
                   seminar.username!,
                    style: hintStyle3,
                  ),
                  Text(
                    seminar.location!,
                    style: hintStyle3,
                  ),
                ],
              ),
            ),
            const VerticalDivider(
              color: gray,
              endIndent: 10,
              indent: 10,
              width: 5,
              thickness: 2,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'عامة',
                    style: labelStyle3,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {

                        print(
                            '=/=/=/=/=/=/=/=/=//=/=/=/=/=/=/=/=/');
                        checked = !checked;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5),
                      child: checked
                          ? const ImageIcon(
                        AssetImage(
                          'assets/bookmark (1).png',
                        ),
                        color: blue,
                      )
                          : const ImageIcon(
                        AssetImage(
                          'assets/bookmark (2).png',
                        ),
                        color: blue,
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    ),
  );
}
