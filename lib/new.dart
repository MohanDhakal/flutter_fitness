import 'package:flutter/material.dart';
import 'package:flutter_new_project/user.dart';

class NextPage extends StatefulWidget {
  final User user;
  NextPage(this.user);
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            child: Text(widget.user.fullname),
          ),
        ),
      ),
    );
  }
}
