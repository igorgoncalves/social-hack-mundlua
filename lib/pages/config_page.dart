import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vetores/pages/about_page.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                        'Ajude a identificar os focos de vetores e faça a diferença contribuindo nas pesquisas.'),
                    CupertinoButton(
                      child: Text(
                        'Políticas de Privacidade',
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Deseja compartilhar seus dados?'),
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.redAccent[100],
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
                Text('Entre em contato'),
                Text('Ajuda sobre o aplicativo'),
                CupertinoButton(
                  child: Text('Sobre o aplicativo'),
                  onPressed: () {
                    print('AboutPage');
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        title: 'Teste',
                        builder: (context) {
                          return AboutPage();
                        },
                      ),
                    );
                  },
                ),
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
      ),
    );
  }
}
