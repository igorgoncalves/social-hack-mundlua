import 'package:flutter/cupertino.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => new _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Adicionar foco',
        ),
      ),
      child: Center(
        child: Text('Adicionar foco'),
      ),
    );
  }
}
