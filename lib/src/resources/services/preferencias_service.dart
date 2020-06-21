import 'package:shared_preferences/shared_preferences.dart';
import 'package:mund_lua/src/models/preferencias.model.dart';

class PreferenciasService {
  void save(Preferencias pref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sharePersonalData', pref.sharePersonalData);
  }

  Future<Preferencias> getPreferencias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('sharePersonalData')) {
      prefs.setBool('sharePersonalData', true);
    }

    return Preferencias(
      sharePersonalData: prefs.getBool('sharePersonalData'),
    );
  }
}
