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
      theme: CupertinoThemeData(
        primaryColor: Colors.redAccent,
        textTheme: CupertinoTextThemeData(
          navTitleTextStyle: TextStyle(
            color: Colors.redAccent,
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}
