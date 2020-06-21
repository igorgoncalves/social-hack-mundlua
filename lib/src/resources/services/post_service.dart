import 'package:mund_lua/src/models/post.model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class PostService {
  Post instancePost;

  PostService(this.instancePost);

  var list = [{}];

  Future getAll() async {
    var queryBuilder = QueryBuilder<Post>(instancePost)
      ..orderByDescending("createdAt");

    return await queryBuilder.query().then((response) {
      print(response.results);
      return response.results.cast<Post>();
    }).catchError((e) {
      print(e);
    });
  }

  Future getAllFilter(String tag) async {
    var queryBuilder = QueryBuilder<Post>(instancePost)
      ..whereEqualTo("hastag", tag)
      ..orderByDescending("createdAt");

    return await queryBuilder.query().then((response) {
      return response.results.cast<Post>();
    }).catchError((e) {
      print(e);
    });
  }
}
