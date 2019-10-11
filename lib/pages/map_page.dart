import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          child: Icon(MdiIcons.helpCircleOutline),
          onPressed: () {
            _launchURL();
          },
        ),
        middle: Text(
          'Mapa',
        ),
      ),
      child: Center(
        child: Text('Mapa'),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://vetores.app';
    if (await canLaunch(url)) {
      await launch(
        url,
        // forceWebView: true,
      );
    } else {
      throw 'Could not launch $url';
      print('deu ruim');
    }
  }
}
