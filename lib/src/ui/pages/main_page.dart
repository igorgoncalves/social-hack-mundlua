import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vetores/src/ui/pages/add_page.dart';
import 'package:vetores/src/ui/pages/config_page.dart';
import 'package:vetores/src/ui/pages/list_page.dart';
import 'package:vetores/src/ui/pages/map_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.white,
        currentIndex: 2,
        border:
            Border(top: BorderSide(color: CupertinoColors.lightBackgroundGray)),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.mapOutline,
              size: 24,
            ),
            activeIcon: Icon(MdiIcons.map),
            title: Text('Mapa'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.cameraOutline,
              size: 24,
            ),
            activeIcon: Icon(MdiIcons.camera),
            title: Text('Novo foco'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.clipboardListOutline,
              size: 24,
            ),
            activeIcon: Icon(MdiIcons.clipboardList),
            title: Text('Ver focos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.settingsOutline,
              size: 24,
            ),
            activeIcon: Icon(MdiIcons.settings),
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
