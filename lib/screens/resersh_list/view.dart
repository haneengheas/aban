import 'package:aban/constant/style.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/screens/resersh_list/search_item.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResershList extends StatelessWidget {
  final String title;
  final List<String> departments;


  const ResershList({Key? key,
    required this.title,
    required this.departments,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {




    var prov = Provider.of<MyModel>(context);
    return DefaultTabController(
      length: departments.length,
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            title: Text(title,
                style: GoogleFonts.cairo(
                  textStyle:const TextStyle(
                      color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                )),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon:const Icon(
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
                        SizedBox(
                            width: sizeFromWidth(context, 1),
                            child:const SearchTextField(
                              text: 'البحث باسم الباحث',
                            )),
                        const SizedBox(
                          height: 7,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: (TabBar(
                                  labelColor: blue,
                                  unselectedLabelColor: gray,
                                  labelStyle: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  isScrollable: true,
                                  tabs: departments.map((e) => Tab(
                                    text: e,
                                  ),).toList(),
                                )),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: TabBarView(
                                    children: departments.map((e) => const SearchItem(),).toList(),
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
