import 'package:aban/constant/style.dart';
import 'package:aban/screens/bookmark/project.dart';
import 'package:aban/screens/bookmark/theses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('المحفوظات',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  color: blue, fontWeight: FontWeight.bold, fontSize: 28),
            )),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    'الندوات',
                    style: bluebold,
                  ),
                ),
                SizedBox(
                  height: sizeFromHeight(context, 2.5),
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: sizeFromWidth(context, 1),
                      height: 110,
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
                                        'اسم الندوة',
                                        style: labelStyle2,
                                      ),
                                      SizedBox(
                                        width: sizeFromWidth(context, 5),
                                      ),
                                      Text(
                                        '24 ابريل2021',
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
                                    'اسم الباحث',
                                    style: hintStyle3,
                                  ),
                                  Text(
                                    'منبي 6 الدور الاول قاعة 23',
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'عامة',
                                      style: labelStyle3,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 20,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: const ImageIcon(
                                        AssetImage(
                                          'assets/bookmark (2).png',
                                        ),
                                        color: blue,
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(
                    'الاطروحات ',
                    style: bluebold,
                  ),
                ),
                const ThesesBookMark(),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(
                    'المشاريع ',
                    style: bluebold,
                  ),
                ),
                const ProjectBookMark(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
