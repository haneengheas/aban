import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/provider/profile_provider.dart';

import 'package:aban/screens/splash_screen/view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
late  bool islogin;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyModel(),
          // child:const MyApp(),
        ),

        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
          // child:const MyApp(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          // child:const MyApp(),
        ),

      ],
      child: const MyApp(),

    ),
  );
}

// late final int counter;
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
void initState() {
    Future.delayed(Duration.zero, () {
      var prov = Provider.of<AuthProvider>(context, listen: false);
      prov.getUserStatus();
      setState(() {});
    });
    FirebaseMessaging.onMessage.listen((event) {
      AwesomeDialog(context: context, title:'title',body: Text('${event.notification!.body}') );
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
