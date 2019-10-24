import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:vetores/src/models/foco.model.dart';

class FocosBloc extends BlocBase {
  
  
  final _service;

  final _coordenadasController = BehaviorSubject<LatLng>();
  final _fotoController = BehaviorSubject<File>();
  final _focosController = BehaviorSubject<List<Foco>>();
  final _loadingController = BehaviorSubject<bool>();

  // O serviço é injetado pelo bloc_pattern em src/inject.dart  
  FocosBloc(this._service);
  
  // Aqui é criada um stream, que é convertido em um observavel (RxDart)
  // a ideia é que quando esse stream for alterado, emita um evento para os
  // observadores
  Observable<List<Foco>> get allFocos => _focosController.stream; //output
  
  Observable<LatLng> get coordenadas => _coordenadasController.stream;

  Observable<File> get foto => _fotoController.stream;
  
  Observable<bool> get isLoading => _loadingController.stream;
  
  
  fetchFocos() async {
    List<Foco> focos = await _service.getAll();
    // Adiciona na transmissão do canal de stream e notifica os observadores
    _focosController.sink.add(focos);
  }
  
  setCoordenadas(LatLng novasCoordenadas) async {
    _coordenadasController.sink.add(novasCoordenadas);
  }

  setFoto(File foto) async {
    _fotoController.sink.add(foto);
  }

  changeIsLoading(bool status) async {
    _loadingController.sink.add(status);
  }

  send() async {  
    
    return _service.add(_coordenadasController.value, _fotoController.value);
  }


  @override
  void dispose() {
    _focosController.close();
    _coordenadasController.close();
    _fotoController.close();
    _loadingController.close();
    super.dispose();  
  } 
}
