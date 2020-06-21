import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/theme_config.dart';
import 'injector.dart';
import 'ui/pages/main_page.dart';

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

  MaterialApp buildCupertinoApp() {
    return MaterialApp(      
      title: 'Mun\'D lua',
      color: ThemeConfig().primaryColor,
      // theme: ThemeConfig().primaryTheme(),
      home: MainPage(),
    );
  }
}
