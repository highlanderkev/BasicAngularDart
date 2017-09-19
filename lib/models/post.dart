library models;

class Post {
    final int id;
    String title;
    
    Post(this.id, this.title)
    
    factory Post.fromJson(Map<String, dynamic> post) => { return new Post(_toInt(post['id']), post['title']); }
    
    Map toJson() => {'id': id, 'title': title};
}

int _toInt(id) => id is int ? id : int.parse(id);