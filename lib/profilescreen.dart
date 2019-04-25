import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
   final name;
   final userDetail;
   ProfileScreen(this.name, this.userDetail);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile Screen ${userDetail["name"]}"),
         ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[Text("This is third screeen$name")],
            ),
          ),
        ),
      ),
    );
  }
}
