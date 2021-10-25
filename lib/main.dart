import 'package:aban/model.dart';
import 'package:aban/screens/splash_screen/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

// late final int counter;
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>  MyModel(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  SplashScreen(),
      ),
    );

  }
}
