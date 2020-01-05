class Reply {
  String userName;
  String userURL;
  String reply;
  List likes;
  // int likeCount;

  Reply({this.reply, this.userURL, this.userName , this.likes});
//factory method to return object from json
  factory Reply.fromJson(Map<dynamic, dynamic> parsedJson) {
    String userNameTemp = parsedJson['userName'].toString();
    String userURLTemp = parsedJson['profileImage'].toString();
    String comment = parsedJson['comment'].toString();
    List likesJsonArray = parsedJson['likes']; 
    return Reply(reply: comment, userName: userNameTemp, userURL: userURLTemp , likes: likesJsonArray);
  }
}
