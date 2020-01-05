import 'package:blog_app/posts/model/reply.model.dart';

class Comment {
  final String authorName;
  final String authorImage;
  final DateTime dateModified;
  final String commentString;
  final List<Reply> childData;

  Comment(
      {this.authorName,
      this.authorImage,
      this.dateModified,
      this.commentString,
      this.childData});

  factory Comment.fromJson(Map<dynamic, dynamic> parsedJson) {
    String userNameTemp = parsedJson['userName'].toString();
    String userURLTemp = parsedJson['profileImage'].toString();
    String comment = parsedJson['comment'].toString();
    List repliesFound = parsedJson['replies'];
    List<Reply> replyList = new List();

    repliesFound.forEach((replyJson) {
      Reply reply = Reply.fromJson(replyJson);
      replyList.add(reply);
    });
    return Comment(
        authorImage: userURLTemp,
        authorName: userNameTemp,
        commentString: comment,
        childData: replyList);
  }
}
