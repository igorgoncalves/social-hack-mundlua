import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:vetores/src/models/foco.model.dart';

class FocosBloc extends BlocBase {
  
  final _service;
  final _focosController = BehaviorSubject<List<Foco>>();

  // O serviço é injetado pelo bloc_pattern em src/inject.dart  
  FocosBloc(this._service);
  
  // Aqui é criada um stream, que é convertido em um observavel (RxDart)
  // a ideia é que quando esse stream for alterado, emita um evento para os
  // observadores
  Observable<List<Foco>> get allFocos => _focosController.stream; //output

  fetchFocos() async {
    List<Foco> focos = await _service.getAll();
    // Adiciona na transmissão do canal de stream e notifica os observadores
    _focosController.sink.add(focos);
  }
  
  @override
  void dispose() {
    _focosController.close();
    super.dispose();  
  } 
}
