import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vetores/src/bloc/focos_bloc.dart';
import 'package:vetores/src/models/foco.model.dart';
import 'package:vetores/src/ui/components/foco_item_list.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final FocosBloc bloc = BlocProvider.getBloc<FocosBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.fetchFocos();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        border: Border(bottom: BorderSide(color: CupertinoColors.white)),
        middle: Text(
          'Ver focos',
        ),
      ),
      child: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: bloc.allFocos,
            builder: (context, AsyncSnapshot<List<Foco>> snapshot) {
              if (snapshot.hasData) {
                return this._buildListFocos(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListFocos(List<Foco> pontosDeFoco) {
    return ListView(
      children: pontosDeFoco.map((f) {
        return FocoItemWidget(
          imagem: f.imagem?.download(),
          lat: f.coordenadas.latitude,
          lng: f.coordenadas.longitude,
          data: f.createdAt,
        );
      }).toList(),
    );
    /* return ListView.builder(
      itemBuilder: (BuildContext context, int index) => FocoItemWidget(
        lat: pontosDeFoco[index].coordenadas.latitude,
        lng: pontosDeFoco[index].coordenadas.longitude,
        imagem: pontosDeFoco[index].imagem?.download(),   
        data: pontosDeFoco[index].createdAt,     
      ),
      itemCount: pontosDeFoco.length,
    );*/
  }
}

// TODO: Verificar design do elemento da lista, jogar no diretorio components
// caso precise reaproveitar esse widget
class FocoSumario extends StatelessWidget {
  final String title, vectorName, date;
  FocoSumario({this.title, this.date, this.vectorName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[Text('$title')],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.network('https://picsum.photos/200/200'),
          ),
          Row(
            children: <Widget>[
              Expanded(child: Text('$vectorName')),
              Text('$date'),
            ],
          ),
        ],
      ),
    );
  }
}
