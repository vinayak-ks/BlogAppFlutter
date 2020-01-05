import 'package:blog_app/posts/model/post.model.dart';

class PostBloc{
  List<Post> getPostList(List jsonList){

    List<Post> postList = new List();
    jsonList.forEach((postJson){
        Post post = Post.fromJson(postJson);
        postList.add(post);
    });
    return postList;

  }
}