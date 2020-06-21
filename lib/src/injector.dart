import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mund_lua/src/resources/services/post_service.dart';

import 'bloc/posts_bloc.dart';
import 'bloc/preferencias_bloc.dart';
import 'models/post.model.dart';
import 'resources/services/preferencias_service.dart';

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
        Bloc((i) => PostsBloc(i.get<PostService>())),
        Bloc((i) => PreferenciasBloc(i.get<PreferenciasService>())),
      ],
      dependencies: [
        // Inject Models
        Dependency((i) => Post()),

        // Inject Services
        Dependency((i) => PostService(i.get<Post>())),
        Dependency((i) => PreferenciasService()),
      ],
    );
  }
}
