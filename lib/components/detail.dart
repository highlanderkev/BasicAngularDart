part of components;

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:kpw_admin_blog/models/post.dart';
import 'package:kpw_admin_blog/services/post.dart';

@Component(
    selector: 'my-post-detail',
    templateUrl: 'detail.html',
    styleUrls: const ['detail.css'])
class PostDetailComponent implements OnInit {
  Post post;
  final PostService _postService;
  final RouteParams _routeParams;
  final Location _location;

  PostDetailComponent(this._postService, this._routeParams, this._location);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) post = await (_postService.getPost(id));
  }

  Future<Null> save() async {
    await _postService.update(post);
    goBack();
  }

  void goBack() => _location.back();
}