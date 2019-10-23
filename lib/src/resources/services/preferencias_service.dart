import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetores/src/models/preferencias.model.dart';

class PreferenciasService {
  void save(Preferencias pref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();    
    await prefs.setBool('sharePersonalData', pref.sharePersonalData);    
  }

  Future<Preferencias> getPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Preferencias(sharePersonalData: prefs.getBool('sharePersonalData'));
  }
}
