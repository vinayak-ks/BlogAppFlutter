import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:blog_app/posts/bloc/credential.bloc.dart';
import 'package:blog_app/posts/view/list_post.view.dart';
import 'package:blog_app/posts/view/view_post.view.dart';
import 'package:blog_app/shared/common_widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  CommonWidget _commonWidget = new CommonWidget();

  TextEditingController _userNameController;
  TextEditingController _passwordController;
  Credential credential;
  List userData;
  @override
  void initState() {
    _userNameController = new TextEditingController();
    _passwordController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    credential = Provider.of<Credential>(context);
    if (userData == null) {
      Future future =
          DefaultAssetBundle.of(context).loadString('data/user.data.json');
      future.then((onValue) {
        print(onValue);
        userData = json.decode(onValue);
        dynamic data = userData[0];
      });
    }
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        backgroundImage: NetworkImage(
            "https://raw.githubusercontent.com/vlang/v-logo/master/dist/v-logo.svg?sanitize=true"),
      ),
    );
    final email = TextFormField(
      controller: _userNameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        if (_userNameController.text.isNotEmpty ||
            _passwordController.text.isNotEmpty) {
          userData.forEach((user) {
            if (user['email'] == _userNameController.text &&
                user['password'] == _passwordController.text) {
              credential.setUserId = user['id'];
              credential.setUserName = user['name'];
              credential.setUserImageUrl = user['profileImage'];
              Navigator.pushNamed(context, PostList.id);
            }
          });
        }
        //
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightBlue[900],
      child: Text('Log In', style: TextStyle(color: Colors.white)),
    );

    final seeMore = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        Navigator.pushNamed(context, PostList.id);
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightBlue[900],
      child: Text('See Posts', style: TextStyle(color: Colors.white)),
    );

    return Scaffold(
      appBar: _commonWidget.getAppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            logo,
            SizedBox(height: 48.0),
            Container(width: 270, child: email),
            SizedBox(height: 20.0),
            Container(
              child: password,
              width: 270,
            ),
            SizedBox(height: 50.0),
            Container(
              child: loginButton,
              width: 270,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: seeMore,
              width: 270,
            )
          ],
        ),
      ),
    );
  }
}
