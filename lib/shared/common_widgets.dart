import 'package:blog_app/constants/blog_app.constans.dart';
import 'package:flutter/material.dart';

class CommonWidget {
  Widget getAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: BlogAppConstants.APP_COLOR,
      title: Text(BlogAppConstants.appTitle),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            //Call the AddPostMethod here
          },
        )
      ],
    );
  }
}
