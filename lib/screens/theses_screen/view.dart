import 'package:aban/constant/style.dart';
import 'package:aban/screens/Home/guestdawer.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/theses_screen/completed_theses.dart';
import 'package:aban/screens/theses_screen/uncompleted_theses.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThesesScreen extends StatefulWidget {
  final int counter;

  ThesesScreen({
    required this.counter,
  });

  @override
  _ThesesScreenState createState() => _ThesesScreenState();
}

class _ThesesScreenState extends State<ThesesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text('أطروحات',
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: blue, fontWeight: FontWeight.bold, fontSize: 28),
              )),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (widget.counter == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationFile(
                            d: studentDrawer(context),
                            title: 'مرحبا"اسم الباحث"',
                            counter: 1)));
              } else if (widget.counter == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationFile(
                            d: guestDrawer(context),
                            title: 'مرحبا',
                            counter: 2)));
              }
            },
            icon: Icon(Icons.arrow_back),
            color: blue,
          ),
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Column(
            children: [
              SearchTextField(
                text: 'البحث عن اطروحة',
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.415,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  border: Border.fromBorderSide(
                      BorderSide(color: lightBlue, width: 1.5)),
                ),
                child: Column(children: [
                  SizedBox(
                    height: 65,
                    child: (TabBar(
                      labelColor: blue,
                      unselectedLabelColor: gray,
                      labelStyle: GoogleFonts.cairo(
                        textStyle:const TextStyle(
                            fontSize: 22,
                            height: 1.5,
                            fontWeight: FontWeight.w800),
                      ),
                      isScrollable: true,
                      tabs: <Widget>[
                        Tab(
                          text: 'غير مكتملة',
                        ),
                        Tab(
                          text: ' مكتملة',
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TabBarView(
                        children: [UnCompletedTheses(), CompletedTheses()],
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
