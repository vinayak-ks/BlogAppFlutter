import 'package:blog_app/posts/bloc/credential.bloc.dart';
import 'package:blog_app/posts/model/comment.model.dart';
import 'package:blog_app/posts/model/post.model.dart';
import 'package:blog_app/posts/model/reply.model.dart';
import 'package:blog_app/shared/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
This page shows  indvidual post with comments and replies
*/
class ViewPost extends StatefulWidget {
  static String id = "view-post";
  final Post post;

  ViewPost({@required this.post}) {
    print("post");
  }

  @override
  _ViewPostState createState() => _ViewPostState(post: this.post);
}

class _ViewPostState extends State<ViewPost> {
  Post post;

  _ViewPostState({this.post}) {
    print(post);
  }
  CommonWidget _commonWidget = new CommonWidget();
  TextEditingController _controller = new TextEditingController();
  TextEditingController _replyController = new TextEditingController();
  ScrollController _scrollController;
  int userID;
  String userName, profileImage;

  double width, height;

  bool _isOnTop = true;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  // To scroll bottom of list
  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    setState(() => _isOnTop = false);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    userID = Provider.of<Credential>(context).userId;
    userName = Provider.of<Credential>(context).userName;
    profileImage = Provider.of<Credential>(context).userImageURL;

    print("object data");
    print(userID);
    // userID = -1;
    return Scaffold(
      body: Column(
        children: <Widget>[
          getPostItem(post),
          Container(
            height: height * 0.55,
            child: ListView.builder(
              itemCount: post.comments.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return getCommentItem(post.comments[index]);
              },
            ),
          ),
          (userID != null)
              ? ListTile(
                  title: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Comment"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() {
                          Comment comment = Comment(
                              commentString: _controller.text,
                              authorImage: profileImage,
                              authorName: userName,
                              dateModified: DateTime.now(),
                              childData: []);
                          post.comments.add(comment);
                          _controller.text = "";
                        });
                      }
                    },
                  ),
                )
              : Container()
        ],
      ),
      appBar: _commonWidget.getAppBar(),
    );
  }

// To get post item
  Widget getPostItem(Post post) {
    return GestureDetector(
      onTap: () {
        print("object");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewPost(post: this.post),
          ),
        );
      },
      child: Container(
        height: height * 0.25,
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
                height: height * 0.2,
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

// Provides UI for each comment
  Widget getCommentItem(Comment comment) {
    print(comment.likes);
    bool isCommentLiked;
    if (userID != null) {
      isCommentLiked = comment.likes.indexOf(userID) >= 0;
      print("comment " );
      
    } else {
      isCommentLiked = false;
    }

    print(isCommentLiked);

    return Card(
      elevation: 5,
      child: ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(comment.authorImage),
                    radius: 20,
                  ),
                ),
                SizedBox(
                  width: width * 0.1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          comment.authorName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    Text(
                      comment.commentString,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                     IconButton(
              icon: Icon(
                Icons.thumb_up,
                size: 15,
                color:  (isCommentLiked) ? Colors.greenAccent : Colors.grey ,
              ),
              onPressed: () {
                setState(() {
                  print("like");
                  if (userID != null) {
                    print("likedd");
                    if (isCommentLiked) {
                      comment.likes.remove(userID);
                    }else{
                      comment.likes.add(userID);
                    }
                  }
                });
              },
            ),
                  ],
                )
              ],
            ),
          ],
        ),
        trailing: Text(
          "reply",
          style:
              TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
        ),
        children: <Widget>[
          (comment.childData.length > 0)
              ? Container(
                  height: height * 0.25,
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: comment.childData.length,
                    itemBuilder: (BuildContext ctxt, int i) {
                      Reply replySingle = comment.childData[i];
                      return getReplyItem(replySingle);
                    },
                  ),
                )
              : Container(),
          (userID != null)
              ? ListTile(
                  title: TextField(
                    autofocus: true,
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: "Reply",
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (_replyController.text.isNotEmpty) {
                        setState(() {
                          print(_replyController.text);
                          Reply reply = new Reply(
                              reply: _replyController.text,
                              userName: userName,
                              userURL: profileImage,
                              likes: []);
                          comment.childData.add(reply);
                          _replyController.text = "";
                          _scrollToBottom();
                        });
                      }
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }

// Provides template for each reply item
  Widget getReplyItem(Reply replySingle) {
    print(replySingle.likes);
    bool _isLiked;
    if (userID != null) {
      _isLiked = replySingle.likes.indexOf(userID) >= 0;
    } else {
      _isLiked = false;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: width * 0.15,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(replySingle.userURL),
            radius: 20,
          ),
          SizedBox(
            width: width * 0.03,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    replySingle.userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: width * 0.20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      color: (_isLiked) ? Colors.greenAccent : Colors.grey,
                      size: 10,
                    ),
                    onPressed: () {
                      setState(() {
                        if (userID != null) {
                          if (_isLiked) {
                            replySingle.likes.remove(userID);
                          } else {
                            replySingle.likes.add(userID);
                          }
                        }
                      });
                    },
                  ),
                ],
              ),
              Text(replySingle.reply),
              SizedBox(
                height: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
