import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetores/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Vetores',
      color: Colors.redAccent,
      theme: CupertinoThemeData(
        primaryColor: Colors.redAccent[100],
        textTheme: CupertinoTextThemeData(
          navTitleTextStyle: TextStyle(
              color: Colors.redAccent[100],
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
      ),
      home: MainPage(),
    );
  }
}
