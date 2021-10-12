import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/complete_seminar.dart';
import 'package:aban/screens/seminar/later_seminar.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeminarScreen extends StatefulWidget {
final int counter;
SeminarScreen({required this.counter});
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State< SeminarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: customAppBar(context, title: 'ندوة'),
        ),
        body: SingleChildScrollView(child:
          Column(
            children: [
              SearchTextField(
                text: "البحث عن ندوة",
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  border: Border.fromBorderSide(
                      BorderSide(color: lightBlue, width: 1.5)),
                ),
                child: Column(children: [
                  SizedBox(
                    height: 60,
                    child: (TabBar(
                      labelColor: blue,
                      unselectedLabelColor: gray,
                      labelStyle: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            fontSize: 22, height: 1.5, fontWeight: FontWeight.w800),
                      ),
                      isScrollable: false,
                      unselectedLabelStyle: labelStyle,
                      indicatorWeight: 0.1,
                      tabs: <Widget>[
                        Tab(
                          text: "قادمة",
                        ),
                        Tab(
                          text: " مكتملة",
                        ),

                      ],
                    )),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TabBarView(
                        children: [LaterSeminar(), CompleteSeminar()],
                      ),
                    ),
                  ),
                ]),
              )

            ],
          ),
        ),
      ),
    );
  }
}
