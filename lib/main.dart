import 'package:blog_app/auth/view/auth.view.dart';
import 'package:blog_app/posts/bloc/credential.bloc.dart';
import 'package:blog_app/posts/view/add_post.view.dart';
import 'package:blog_app/posts/view/list_post.view.dart';
import 'package:blog_app/posts/view/view_post.view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Credential>(
      builder: (_) => Credential(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        routes: {
          LoginPage.id: (context) => LoginPage(),
          AddPost.id: (context) => AddPost(),
          PostList.id: (context) => PostList(),
          ViewPost.id: (context) => ViewPost()
        },
      ),
    );
  }
}
