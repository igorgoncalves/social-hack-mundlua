import 'package:flutter/cupertino.dart';
import 'package:vetores/pages/add_page.dart';
import 'package:vetores/pages/config_page.dart';
import 'package:vetores/pages/list_page.dart';
import 'package:vetores/pages/map_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.location),
            title: Text('Mapa'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.photo_camera),
            title: Text('Novo foco'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.eye),
            title: Text('Ver focos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear),
            title: Text('Ajustes'),
          ),
        ],
      ),
      tabBuilder: (context, i) {
        var pages = [MapPage(), AddPage(), ListPage(), ConfigPage()];
        return CupertinoTabView(
          builder: (context) {
            return pages[i];
          },
        );
      },
    );
  }
}
