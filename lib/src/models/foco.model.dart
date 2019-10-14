
import 'package:parse_server_sdk/parse_server_sdk.dart';


class Foco extends ParseObject implements ParseCloneable {
  Foco() : super(_keyTableName);
  Foco.clone() : this();    

  /// Looks strangely hacky but due to
  ///  Flutter not using reflection, we have to
  /// mimic a clone
  @override
  clone(Map map) => Foco.clone()..fromJson(map);

  static const String _keyTableName = 'Foco';
  static const String keyLat = 'lat';
  static const String keyLng = 'lng';
  static const String keyImagem = 'imagem';

  String get lat => get<String>(keyLat);
  set lat(String lat) => set<String>(keyLat, lat);

  String get lng => get<String>(keyLng);
  set lng(String lng) => set<String>(keyLng, lng);

  ParseFile get imagem => get<ParseFile>(keyImagem);
  set imagem(ParseFile imagem) => set<ParseFile>(keyImagem, imagem);  
}
