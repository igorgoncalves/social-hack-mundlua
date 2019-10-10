import 'package:flutter/cupertino.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Ver focos',
        ),
      ),
      child: Center(
        child: Text('Listar focos'),
      ),
    );
  }
}
