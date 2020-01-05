import 'package:blog_app/posts/model/comment.model.dart';
import 'package:flutter/foundation.dart';

class Post {
  final String title;
  String userName;
  String imageURL;
  List<Comment> comments;

  Post({this.title, this.userName, this.imageURL, this.comments});

  factory Post.fromJson(Map<dynamic, dynamic> parsedJson) {
    String titleTemp = parsedJson['title'];
    String imageUrl = parsedJson['imageURl'];
    List comments = parsedJson['comments'];
    List<Comment> commentList = new List();
    comments.forEach((commentJson) {
      Comment comment = Comment.fromJson(commentJson);
      commentList.add(comment);
    });

    return Post(title: titleTemp, imageURL: imageUrl, comments: commentList);
  }

  
  
}
