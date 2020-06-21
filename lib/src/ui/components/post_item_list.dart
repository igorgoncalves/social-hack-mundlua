import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostItemWidget extends StatelessWidget {
  final String id;
  final String titulo;
  final String descricao;
  final String hastag;
  final String tipo;
  final String link;

  PostItemWidget({
    Key key,
    @required this.id,
    @required this.titulo,
    @required this.descricao,
    @required this.hastag,
    @required this.tipo,
    @required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller;

    if (tipo == "video") {
      _controller = YoutubePlayerController(
        initialVideoId: id,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            tipo == "video"
                ? YoutubePlayer(
                    controller: _controller,
                    liveUIColor: Colors.amber,
                  )
                : Container(
                    height: 250,
                    child: PhotoView(
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      imageProvider: NetworkImage(link),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hastag,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green),
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    titulo,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                    width: 50,
                    child: IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          Share.share(
                              'Vi esse contéudo e acho que ele pode ajudar você. Ele se chama ${titulo}, e pode ser acessado em: ${link} ou baixe o app Mun\'D Lua e veja esse e muito mais');
                        }))
              ],
            ),
            Text(
              descricao,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: Image.asset("assets/divider.png"),
            )
          ],
        ),
      ),
    );
  }
}
