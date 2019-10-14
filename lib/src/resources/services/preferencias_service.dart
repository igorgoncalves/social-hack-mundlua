
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetores/src/models/preferencias.model.dart';

class PreferenciasService {
  
  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  Future<Preferencias> getPreferencias () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    

    return Preferencias();
  }

}
