
import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:vetores/src/bloc/focos_bloc.dart';
import 'package:vetores/src/models/foco.model.dart';
import 'package:vetores/src/resources/services/foco_service.dart';

class Injector extends StatelessWidget {
  // This widget is the root of your application.
  final Widget child;

  Injector({Key key, this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: this.child,
      //Adicionar blocs para injeção de dependencia
      blocs: [
        Bloc((i) => FocosBloc(i.get<FocoService>())),
      ],
      dependencies: [
        // Inject Models
        Dependency((i) => Foco()),        

        // Inject Services
        Dependency((i) => FocoService(i.get<Foco>())),

      ],
    );
  }
}