import 'package:flutter/material.dart';
//for sharing the userDetails accross the app
class Credential with ChangeNotifier {
  int _userId;
  String _userName;
  String _userImageURL;

  int get userId => _userId;
  String get userName => _userName;
  String get userImageURL => _userImageURL;

  set setUserId(int userID) {
    _userId = userID;
    notifyListeners();
  }

  set setUserName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  set setUserImageUrl(String imageUrl) {
    _userImageURL = imageUrl;
    notifyListeners();
  }
}
