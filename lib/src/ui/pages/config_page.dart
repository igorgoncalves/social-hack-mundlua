import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetores/src/bloc/preferencias_bloc.dart';
import 'package:vetores/src/config/theme_config.dart';
import 'package:vetores/src/models/preferencias.model.dart';
import 'package:vetores/src/ui/pages/about_page.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final PreferenciasBloc bloc = BlocProvider.getBloc<PreferenciasBloc>();

  @override
  Widget build(BuildContext context) {
    bool _share = true;
    bloc.loadPrefs();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: Border(bottom: BorderSide(color: CupertinoColors.white)),
        middle: Text(
          'Ajustes',
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder(
                  stream: bloc.allPreferences,
                  builder: (context, AsyncSnapshot<Preferencias> snapshot) {
                    if(snapshot.hasData){
                      return _listPreferences(snapshot.data, context);
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ),
      ),
    );
  }

  ListView _listPreferences(Preferencias prefs, BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 64, top: 32, bottom: 16),
              child: Column(
                children: <Widget>[
                  Text(
                    'Ajude a identificar os focos de vetores e faça a diferença contribuindo nas pesquisas.',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: CupertinoColors.inactiveGray),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.all(0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Políticas de Privacidade',
                      ),
                    ),
                    onPressed: () {
                      
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text('Deseja compartilhar seus dados?'),
            ),
            CupertinoSwitch(
              activeColor: ThemeConfig().primaryColor[100],
              onChanged: (bool value) {                
                bloc.changePrefs(Preferencias(sharePersonalData: value));
              },
              value: prefs.sharePersonalData,
            ),
          ],
        ),
        Divider(),
        Text('Entre em contato'),
        Divider(),
        Text('Ajuda sobre o aplicativo'),
        Divider(),
        CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sobre o aplicativo',
              style: TextStyle(color: CupertinoColors.black),
            ),
          ),
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
        Divider(),
        CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Deletar todos os meus dados',
            ),
          ),
          onPressed: () {
            print('Deletar todos os meus dados');
          },
        ),
        Divider(),
        Text(
          'Versão 0.1.0',
          style: TextStyle(color: CupertinoColors.lightBackgroundGray),
        )
      ],
    );
  }
}
