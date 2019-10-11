import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Texto'),
              Column(
                children: <Widget>[
                  Text('Deseja compartilhar seus dados?'),
                  CupertinoSwitch(
                    activeColor: Colors.redAccent,
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
              CupertinoButton(
                child: Text('Deletar todos os meus dados'),
                onPressed: () {
                  print('Deletar todos os meus dados');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
