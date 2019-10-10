import 'package:flutter/cupertino.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Mapa',
        ),
      ),
      child: Center(
        child: Text('Mapa'),
      ),
    );
  }
}
