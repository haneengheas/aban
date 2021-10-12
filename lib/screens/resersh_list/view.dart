import 'package:aban/constant/style.dart';
import 'package:aban/screens/resersh_list/search_item.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResershList extends StatelessWidget {
  final String title;


  ResershList({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            title: Text(title,
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                )),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(
              Icons.arrow_back,
              color: blue,
            ),)
          ),
          body: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: sizeFromWidth(context, 1),
                            child: SearchTextField(
                              text: 'البحث باسم الباحث',
                            )),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: (TabBar(
                                  labelColor: blue,
                                  unselectedLabelColor: gray,
                                  labelStyle: GoogleFonts.cairo(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  isScrollable: false,
                                  tabs: <Widget>[
                                    Tab(
                                      text: 'هندسة \nالبرمجيات',
                                    ),
                                    Tab(
                                      text: 'نظم \n المعلومات',
                                    ),
                                    Tab(
                                      text: 'تقنية \n المعلومات',
                                    ),
                                    Tab(
                                      text: 'علوم \n الحاسب',
                                    ),
                                  ],
                                )),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: TabBarView(
                                    children: [
                                      SearchItem(),
                                      SearchItem(),
                                      SearchItem(),
                                      SearchItem(),

                                      // Text('data'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
