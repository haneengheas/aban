import 'package:aban/constant/style.dart';
import 'package:aban/screens/bookmark/project.dart';
import 'package:aban/screens/bookmark/seminar.dart';
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
               const SeminarBookmark(),
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
