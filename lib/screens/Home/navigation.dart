import 'package:aban/constant/style.dart';
import 'package:aban/screens/Home/view.dart';
import 'package:aban/screens/project_screen/view.dart';
import 'package:aban/screens/seminar/view.dart';
import 'package:aban/screens/theses_screen/view.dart';
import 'package:flutter/material.dart';

class NavigationFile extends StatefulWidget {
  final Widget d ;
  final String title;
  final int counter;

  late final List <Widget> pages;
  NavigationFile({Key? key,  required this.d,required this.title,required this.counter,}) : super(key: key){
    pages=[
      HomeScreen(c: d, title: title,),
      ProjectScreen(counter: counter,),
      ThesesScreen(counter:counter),
      SeminarScreen(counter: counter,) ,   ];
  }
  @override
  _NavigationFileState createState() => _NavigationFileState();
}

class _NavigationFileState extends State<NavigationFile> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  widget.pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: blue,
        selectedLabelStyle: hintStyle4,
        unselectedLabelStyle: hintStyle4,
        selectedItemColor: white,
        unselectedItemColor: white,
        iconSize: 40,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: 25,color: white,), label: 'الرئيسية',),
          BottomNavigationBarItem(icon: Image(image: AssetImage('assets/bar-chart.png',),height: 25,color: white,), label: 'مشاريع'),
          BottomNavigationBarItem(icon: Image(image: AssetImage('assets/newsletter.png'),height: 25,color: white,), label: 'أطروحات'),
          BottomNavigationBarItem(icon: Image(image: AssetImage('assets/class.png'),height: 25,color: white,), label: 'ندوات'),
        ],
      ),
    );
  }
}
