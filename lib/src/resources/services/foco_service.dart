import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:vetores/src/models/foco.model.dart';

class FocoService {
  Foco _focoDataAccess;  

  FocoService(this._focoDataAccess);

  Future add(String lat, String lng, [File imagem]) async {
    final parseFile = ParseFile(imagem);
    
    var item = this._focoDataAccess;
    item.set('lat', lat);
    item.set('lng', lng);
    item.set('imagem', parseFile);

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
