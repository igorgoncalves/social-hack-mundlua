import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:vetores/src/models/foco.model.dart';

class FocoService {
  Foco _focoDataAccess;  

  FocoService(this._focoDataAccess);

  Future add(LatLng coordenadas, [File imagem]) async {
    final parseFile = ParseFile(imagem);
    final geoPoint =  ParseGeoPoint(latitude: coordenadas.latitude, longitude: coordenadas.longitude);
    
    var item = this._focoDataAccess;
    item.set('coordenadas', geoPoint);
    item.set('foto', parseFile);
    item.set('aprovado', false);
  
    return await item.save();
  }

  Future getAll() async {
    var queryBuilder = QueryBuilder<Foco>(_focoDataAccess)
      ..whereEqualTo(Foco.keyAprovado, true)
      ..orderByDescending("createdAt");

    return await queryBuilder.query().then((response) {
      return response.results.cast<Foco>();
    }).catchError((e){
      print(e);
    });
  }

  Future getById(String id) async {
    return await this._focoDataAccess.getObject(id);
  }

}
