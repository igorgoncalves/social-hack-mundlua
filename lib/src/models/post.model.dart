import 'package:parse_server_sdk/parse_server_sdk.dart';

class Post extends ParseObject implements ParseCloneable {
  Post() : super(_keyTableName);
  Post.clone() : this();

  /// Looks strangely hacky but due to
  ///  Flutter not using reflection, we have to
  /// mimic a clone
  @override
  clone(Map map) => Post.clone()..fromJson(map);

  static const String _keyTableName = 'Post';
  static const String keyLink = 'link';
  static const String keyTitulo = 'titulo';
  static const String keyDescricao = 'descricao';
  static const String keyTipo = 'tipo';
  static const String keyHastag = 'hastag';

  String get link => get<String>(keyLink);
  set link(String link) => set<String>(keyLink, link);

  String get titulo => get<String>(keyTitulo);
  set titulo(String titulo) => set<String>(keyTitulo, titulo);

  String get descricao => get<String>(keyDescricao);
  set descricao(String descricao) => set<String>(keyDescricao, descricao);

  String get tipo => get<String>(keyTipo);
  set tipo(String tipo) => set<String>(keyTipo, tipo);

  String get hastag => get<String>(keyHastag);
  set hastag(String hastag) => set<String>(keyHastag, hastag);
}
