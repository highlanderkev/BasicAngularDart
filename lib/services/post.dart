library services;

import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:http/http.dart';

import 'package:kpw_admin_blog/models/post.dart';

@Injectable()
class PostService {
    static final _headers = {'Content-Type': 'application/json'};
    static const _postUrl = 'https://api.kevinpatrickwestropp.com/posts';
    
    final Client _http;
    
    PostService(this._http);
    
    Future<List<Post>> getPosts() async {
        try {
            final response = await _http.get(_postUrl);
            final posts = _extractData(response).map((value) => new Post.fromJson(value)).toList();
            return posts;
        } catch(e) {
            throw _handleError(e);
        }
    }
    
    dynamic _extractData(Response resp) => JSON.decode(resp.body)['data'];
    
    Exception _handleError(dynamic e) {
        print(e);
        return new Exception('Server error: cause: $e');
    }
    
    Future<Post> getPost(int id) async {
        try {
            final response = await _http.get('$_postUrl/$id');
            return new Post.fromJson(_extractData(response));
        } catch (e) {
            throw _handleError(e);
        }
    }
    
    Future<Post> create(String title) async {
        try {
            final response = await _http.post(_postUrl, headers: _headers, body: JSON.encode({'title': title}));
            return new Post.fromJson(_extractData(response));
        } catch (e) {
            throw _handleError(e);
        }
    }
    
    Future<Post> update(Post post) async {
        try {
            final url = '$_postUrl/${post.id}';
            final response = await _http.put(url, headers: _headers, body: JSON.encode(post));
            return new Post.fromJson(_extractData(response));
        } catch (e) {
            throw _handleError(e);
        }
    }
    
    Future<Null> delete(int id) async {
        try {
            final url = '$_postUrl/$id';
            await _http.delete(url, headers: _headers);
        } catch (e) {
            throw _handleError(e);
        }
    }
}