import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FocoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Detalhes do foco',
        ),
      ),
      child: SafeArea(
        child: Center(
            child: Icon(
          MdiIcons.shield,
          size: 64,
        )),
      ),
    );
    ;
  }
}