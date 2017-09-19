part of services;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:angular2/core.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:kpw_admin_blog/models/post.dart';

@Injectable()
class InMemoryDataService extends MockClient {
  static final _initialPosts = [
    {'id': 11, 'title': 'Mr. Nice'},
    {'id': 12, 'title': 'Narco'},
    {'id': 13, 'title': 'Bombasto'},
    {'id': 14, 'title': 'Celeritas'},
    {'id': 15, 'title': 'Magneta'},
    {'id': 16, 'title': 'RubberMan'},
    {'id': 17, 'title': 'Dynama2'},
    {'id': 18, 'title': 'Dr IQ'},
    {'id': 19, 'title': 'Magma'},
    {'id': 20, 'title': 'Tornado'}
  ];
  static final List<Post> _postDb =
      _initialPosts.map((json) => new Post.fromJson(json)).toList();
  static int _nextId = _postDb.map((post) => post.id).fold(0, max) + 1;

  static Future<Response> _handler(Request request) async {
    var data;
    switch (request.method) {
      case 'GET':
        final id =
            int.parse(request.url.pathSegments.last, onError: (_) => null);
        if (id != null) {
          data = _postDb
              .firstWhere((post) => post.id == id); // throws if no match
        } else {
          String prefix = request.url.queryParameters['title'] ?? '';
          final regExp = new RegExp(prefix, caseSensitive: false);
          data = _postDb.where((post) => post.title.contains(regExp)).toList();
        }
        break;
      case 'POST':
        var name = JSON.decode(request.body)['title'];
        var newPost = new Post(_nextId++, title);
        _postDb.add(newPost);
        data = newPost;
        break;
      case 'PUT':
        var postChanges = new Post.fromJson(JSON.decode(request.body));
        var target = _postDb.firstWhere((p) => p.id == postChanges.id);
        target.title = postChanges.title;
        data = target;
        break;
      case 'DELETE':
        var id = int.parse(request.url.pathSegments.last);
        _postDb.removeWhere((post) => post.id == id);
        // No data, so leave it as null.
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }
    return new Response(JSON.encode({'data': data}), 200,
        headers: {'content-type': 'application/json'});
  }

  InMemoryDataService() : super(_handler);
}