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

    return await item.save();
  }

  Future getAll() async {
    return await this._focoDataAccess.getAll().then((response) {
      return response.results.cast<Foco>();
    }).catchError((e){
      print(e);
    });
  }

  Future getById(String id) async {
    return await this._focoDataAccess.getObject(id);
  }

}
