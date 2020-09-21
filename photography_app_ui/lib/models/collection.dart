import 'package:photography_app_ui/models/post.dart';

class Collocation {
  final String name;
  final String thumbnail;
  final List<String> tags;
  final List<Post> posts;

  Collocation({this.name, this.thumbnail, this.tags, this.posts});
}