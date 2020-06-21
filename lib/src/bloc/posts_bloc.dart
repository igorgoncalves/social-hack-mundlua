import 'package:mund_lua/src/models/post.model.dart';
import 'package:mund_lua/src/resources/services/post_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class PostsBloc extends BlocBase {
  final PostService _service;

  final _postsController = BehaviorSubject<List<Post>>();
  final _loadingController = BehaviorSubject<bool>();

  // O serviço é injetado pelo bloc_pattern em src/inject.dart
  PostsBloc(this._service);

  // Aqui é criada um stream, que é convertido em um observavel (RxDart)
  // a ideia é que quando esse stream for alterado, emita um evento para os
  // observadores
  Observable<List<Post>> get allPosts => _postsController.stream; //output

  fetchPosts() async {
    List<Post> posts = await _service.getAll();
    _postsController.sink.add(posts);
  }

  filterPosts(String tag) async {
    List<Post> posts = await _service.getAllFilter(tag);
    _postsController.sink.add(posts);
  }

  @override
  void dispose() {
    _postsController.close();
    _loadingController.close();

    super.dispose();
  }
}
