import 'dart:convert';

import 'package:blog_app/posts/bloc/posts.bloc.dart';
import 'package:blog_app/posts/model/comment.model.dart';
import 'package:blog_app/posts/model/post.model.dart';
import 'package:blog_app/posts/model/reply.model.dart';
import 'package:blog_app/posts/view/view_post.view.dart';
import 'package:blog_app/shared/common_widgets.dart';
import 'package:flutter/material.dart';

// This page provides List of posts
class PostList extends StatefulWidget {
  static String id = "list-post";

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  CommonWidget _commonWidget = new CommonWidget();
  PostBloc postBloc = new PostBloc();
  List<Comment> _commentList;
  List<Post> _postList;

  @override
  void initState() {
    _postList = new List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_postList.isEmpty) {
      Future furePost =
          DefaultAssetBundle.of(context).loadString('data/posts.data.json');
      furePost.then((result) {
        if (result != null) {
          setState(() {
            dynamic postData = json.decode(result);
            _postList = postBloc.getPostList(postData);
            print(_postList);
          });
        }
      });
    }
    return Scaffold(
      appBar: _commonWidget.getAppBar(),
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: _postList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return getPostItem(_postList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget getPostItem(Post post) {
    return GestureDetector(
      onTap: () {
        print("object");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewPost(post: post),
          ),
        );
      },
      child: Container(
        height: 150,
        child: Card(
          elevation: 5,
          child: Column(
            children: <Widget>[
              Text(
                post.title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Container(
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(post.imageURL))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
