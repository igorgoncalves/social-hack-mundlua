import 'package:flutter/cupertino.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    bool _share = true;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Ajustes',
        ),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Texto'),
            Column(
              children: <Widget>[
                Text('Deseja compartilhar seus dados?'),
                CupertinoSwitch(
                  onChanged: (bool value) {
                    setState(
                      () {
                        _share = value;
                      },
                    );
                  },
                  value: _share,
                ),
              ],
            ),
            Text('Texto'),
            Text('Texto'),
            Text('Texto'),
            Text('Deletar todos os meus dados'),
          ],
        ),
      ),
    );
  }
}
