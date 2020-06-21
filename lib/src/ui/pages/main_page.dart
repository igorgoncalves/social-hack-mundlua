import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mund_lua/src/bloc/posts_bloc.dart';
import 'package:mund_lua/src/models/post.model.dart';
import 'package:mund_lua/src/ui/components/post_item_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PostsBloc bloc = BlocProvider.getBloc<PostsBloc>();

  final List<String> tags = [
    "#all",
    "#divisibilidade",
    "#logaritmo",
    "#logaritmo",
    "#logaritmo",
    "#logaritmo",
    "#logaritmo"
  ];

  @override
  void initState() {
    bloc.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        // border: Border(bottom: BorderSide(color: CupertinoColors.white)),
        title: Text(
          'Mun\'D lua',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(30, 20, 20, 0),
              child: Text(
                "Filtrar por tag",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10),
                  children: tags.map((f) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: RaisedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(f),
                          ),
                          onPressed: () {
                            if (f == "#all") {
                              bloc.fetchPosts();
                            }
                            bloc.filterPosts(f);
                          },
                          textColor: Colors.green,
                          padding: EdgeInsets.all(0),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          )),
                    );
                  }).toList()),
            ),
            Expanded(
              child: StreamBuilder(
                stream: bloc.allPosts,
                builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                  if (snapshot.hasData) {
                    return this._buildListFocos(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListFocos(List<Post> pontosDeFoco) {
    return ListView(
      children: pontosDeFoco.map((f) {
        return PostItemWidget(
          titulo: f.titulo,
          descricao: f.descricao,
          id: YoutubePlayer.convertUrlToId(f.link),
          hastag: f.hastag,
          tipo: f.tipo,
          link: f.link,
        );
      }).toList(),
    );
  }
}
