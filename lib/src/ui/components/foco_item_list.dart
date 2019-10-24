

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetores/src/config/theme_config.dart';

class FocoItemWidget extends StatelessWidget {
  final double lat;
  final double lng;
  final String imagem;
  final DateTime data;

  const FocoItemWidget({
    Key key,
    @required this.lat,
    @required this.lng,
    @required this.imagem,
    @required this.data,
  })  : assert(lat != null),
        assert(lng != null),
        assert(data != null),
        assert(imagem != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Lat: $lat | Long: $lng',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.network(
                  imagem,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'Aedes Aegypti',
                  style: TextStyle(
                      color: ThemeConfig().primaryColor[100],
                      fontWeight: FontWeight.normal,
                      fontSize: 24),
                )),
                Text(
                  '${formatDate(data, [dd, '/', mm, '/', yy])}',
                  style: TextStyle(
                      fontSize: 16, color: CupertinoColors.inactiveGray),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   child: Padding(
    //     padding: EdgeInsets.all(8.0),
    //     child: Container(
    //         child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: <Widget>[
    //         ClipRRect(
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(8.0),
    //             topRight: Radius.circular(8.0),
    //           ),
    //           child: Image.network(
    //             imagem,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         Text(
    //           'Coordenadas',
    //           style: TextStyle(fontWeight: FontWeight.bold),
    //           textAlign: TextAlign.center,
    //         ),
    //         Text(
    //           'Latitude: $lat | Longitude: $lng',
    //           textAlign: TextAlign.center,
    //         ),
    //       ],
    //     )),
    //   ),
    // );
  }
}
