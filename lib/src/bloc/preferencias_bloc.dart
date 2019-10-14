import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:vetores/src/models/preferencias.model.dart';
import 'package:vetores/src/resources/services/foco_service.dart';
import 'package:vetores/src/resources/services/preferencias_service.dart';


class PreferenciasBloc extends BlocBase {
  
  final PreferenciasService _service;
  final _prefsController = BehaviorSubject<Preferencias>();
  
  PreferenciasBloc(this._service);
  
  Observable<Preferencias> get allFocos => _prefsController.stream;

  loadPrefs() async {
    Preferencias prefs = await _service.getPreferencias();
    _prefsController.sink.add(prefs);
  }
  
  @override
  void dispose() {
    _prefsController.close();
    super.dispose();  
  } 
}
