library components;

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:kpw_admin_blog/models/post.dart';
import 'package:kpw_admin_blog/services/post.dart';

@Component(
    selector: 'my-posts',
    templateUrl: 'posts.html',
    styleUrls: const ['posts.css'],
    directives: const [PostDetailComponent])
class PostsComponent implements OnInit {
  List<Post> posts;
  Post selectedPost;

  final PostService _postService;
  final Router _router;

  PostsComponent(this._postService, this._router);

  Future<Null> getPosts() async {
    posts = await _postService.getHeroes();
  }

  Future<Null> add(String title) async {
    title = title.trim();
    if (title.isEmpty) return;
    posts.add(await _postService.create(title));
    selectedHero = null;
  }

  Future<Null> delete(Post post) async {
    await _postService.delete(post.id);
    posts.remove(post);
    if (selectedPost == post) selectedPost = null;
  }

  void ngOnInit() {
    getPosts();
  }

  void onSelect(Post post) {
    selectedPost = post;
  }

  Future<Null> gotoDetail() => _router.navigate([
        'PostDetail',
        {'id': selectedPost.id.toString()}
      ]);
}