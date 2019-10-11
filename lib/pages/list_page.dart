import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Ver focos',
        ),
      ),
      child: SafeArea(
        child: Center(
          child: CupertinoScrollbar(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocoSumario(
                    title: 'Titulo',
                    vectorName: 'Aedes Aegypti',
                    date: 'hoje',
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocoSumario(
                    title: 'Titulo',
                    vectorName: 'Aedes Aegypti',
                    date: 'hoje',
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocoSumario(
                    title: 'Titulo',
                    vectorName: 'Aedes Aegypti',
                    date: 'hoje',
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocoSumario(
                    title: 'Titulo',
                    vectorName: 'Aedes Aegypti',
                    date: 'hoje',
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocoSumario(
                    title: 'Titulo',
                    vectorName: 'Aedes Aegypti',
                    date: 'hoje',
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FocoSumario(
                    title: 'Titulo',
                    vectorName: 'Aedes Aegypti',
                    date: 'hoje',
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
