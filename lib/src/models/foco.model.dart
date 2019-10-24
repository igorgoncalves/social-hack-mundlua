
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
  static const String keyCoordenadas = 'coordenadas';
  static const String keyImagem = 'foto';
  static const String keyCreatedAt = 'createdAt';
  

  ParseGeoPoint get coordenadas => get<ParseGeoPoint>(keyCoordenadas);
  set coordenadas(ParseGeoPoint coordenadas) => set<ParseGeoPoint>(keyCoordenadas, coordenadas);

  ParseFile get imagem => get<ParseFile>(keyImagem);
  set imagem(ParseFile imagem) => set<ParseFile>(keyImagem, imagem);  
  
  DateTime get criadoEm => get<DateTime>(keyCreatedAt);
  set criadoEm(DateTime criadoEm) => set<DateTime>(keyCreatedAt, criadoEm);
  
}
