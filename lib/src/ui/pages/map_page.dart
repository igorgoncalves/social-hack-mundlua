import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vetores/src/ui/components/mapa.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: Border(bottom: BorderSide(color: CupertinoColors.white)),
        // trailing: CupertinoButton(
        //   child: Icon(MdiIcons.helpCircleOutline),
        //   onPressed: () {
        //     _launchURL();
        //   },
        // ),
        middle: Text(
          'Mapa',
        ),
      ),
      child: SafeArea(
        child: Center(
          child: MapVetores(),
        ),
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
    }
  }
}
