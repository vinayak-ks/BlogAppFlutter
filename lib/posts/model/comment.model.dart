import 'package:blog_app/posts/model/reply.model.dart';

class Comment {
   String authorName;
   String authorImage;
   DateTime dateModified;
   String commentString;
   List likes;
   List<Reply> childData;

  Comment(
      {this.authorName,
      this.authorImage,
      this.dateModified,
      this.commentString,
      this.childData,
      this.likes});
//factory method to return object from json
  factory Comment.fromJson(Map<dynamic, dynamic> parsedJson) {
    String userNameTemp = parsedJson['userName'].toString();
    String userURLTemp = parsedJson['profileImage'].toString();
    String comment = parsedJson['comment'].toString();
    List likesJson = parsedJson['likes'];
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
        likes: likesJson,
        childData: replyList);
  }
}
