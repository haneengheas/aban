import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/seminar_details.dart';
import 'package:aban/screens/seminar/seminar_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_seminar.dart';

class CompleteSeminar extends StatefulWidget {
  const CompleteSeminar(this.filter, this.seminar, {Key? key})
      : super(key: key);

  final List<SeminarModel> seminar;
  final String? filter;

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<CompleteSeminar> {
  bool checked = true;
  bool? isFav = false;

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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('seminar')
                .where('selectedDay', isLessThanOrEqualTo: DateTime.now())
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SeminarDetails(
                          //               description: snapshot.data!.docs[index]
                          //                   ['discription'],
                          //               from: snapshot.data!.docs[index]
                          //                   ['from'],
                          //               link: snapshot.data!.docs[index]
                          //                   ['link'],
                          //               location: snapshot.data!.docs[index]
                          //                   ['location'],
                          //               selectday: snapshot.data!.docs[index]
                          //                   ['selectday'],
                          //               seminarname: snapshot.data!.docs[index]
                          //                   ['seminarname'],
                          //               to: snapshot.data!.docs[index]
                          //                   ['to'],
                          //               type: snapshot.data!.docs[index]
                          //                   ['type'],
                          //               userid: snapshot.data!.docs[index]
                          //                   ['userid'],
                          //               username: snapshot.data!.docs[index]
                          //                   ['username'],
                          //             )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]
                                          ['seminaraddress'],
                                          style: labelStyle3,
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
                                      snapshot.data!.docs[index]['username'],
                                      style: hintStyle3,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['to'] + 'pm',
                                          style: hintStyle3,
                                        ),
                                        Text(
                                          ':' +
                                              snapshot.data!.docs[index]['from']
                                                  .toString() +
                                              'pm',
                                          style: hintStyle3,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['location'],
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
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['type'] == 1
                                              ? 'عامة'
                                              : 'خاصة',
                                          style: labelStyle3,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              isFav = isFav!;
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 25,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: isFav == true
                                                ? const ImageIcon(
                                              AssetImage(
                                                'assets/bookmark (1).png',
                                              ),
                                              color: blue,
                                              size: 50,
                                            )
                                                : const ImageIcon(
                                              AssetImage(
                                                'assets/bookmark (2).png',
                                              ),
                                              color: blue,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return const Text('');
            },
          ),
        ),
      ],
    );
  }

  Widget buildSeminarBox(SeminarModel seminar) => InkWell(
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
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            print('=/=/=/=/=/=/=/=/=//=/=/=/=/=/=/=/=/');
                            checked = !checked;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
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
