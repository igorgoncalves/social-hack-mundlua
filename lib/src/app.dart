import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetores/src/injector.dart';
import 'package:vetores/src/ui/pages/main_page.dart';

import 'config/theme_config.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Adiciono o widget com as injeções de dependencia no top da
    // árvore de Widgets, assim todos podem ter acesso aos blocs
    return Injector(
      child: buildCupertinoApp(),
    );
  }

  CupertinoApp buildCupertinoApp() {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Vetores',
      color: ThemeConfig().primaryColor,
      theme: ThemeConfig().primaryTheme(),
      home: MainPage(),
    );
  }
}
