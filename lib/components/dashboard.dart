part of components;

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:kpw_admin_blog/models/post.dart';
import 'package:kpw_admin_blog/services/post.dart';

@Component(
    selector: 'my-dashboard',
    templateUrl: 'dashboard.html',
    styleUrls: const ['dashboard.css'],
    directives: const [ROUTER_DIRECTIVES])
class Dashboard implements OnInit {
  List<Post> posts;

  final PostService _postService;

  Dashboard(this._postService);

  Future<Null> ngOnInit() async {
    heroes = (await _postService.getPosts()).skip(1).take(4).toList();
  }
}
