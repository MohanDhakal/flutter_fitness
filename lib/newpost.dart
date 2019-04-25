import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

class AddNewPost extends StatefulWidget {
  @override
  _AddNewPostState createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  DatabaseReference itemRef;
  final myGlobalKey = GlobalKey<FormState>();
  BlogPost blogPost = BlogPost("", "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('BlogItems');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: myGlobalKey,
          child: Container(
            child: Column(
              children: <Widget>[
                titleField(),
                ContentField(),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    minWidth: 350,
                    padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      sendDatatofirebase();
                    },
                    child: Text(
                      "Send to Firebase",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void sendDatatofirebase() {
    final FormState form = myGlobalKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(blogPost.toJson());
    }
  }

  Widget titleField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: null,
        validator: (value) {
          return value.isEmpty ? "Title Can't be empty" : null;
        },
        onSaved: (value) {
          blogPost.title = value;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          hintText: "Enter Your Blog Title here",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
          labelText: "Title",
        ),
        style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  Widget ContentField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: null,
        validator: (value) {
          return value.isEmpty ? "You must have some content" : null;
        },
        onSaved: (value) {
          blogPost.content = value;
        },
        decoration: InputDecoration(
            labelText: "Content",
            contentPadding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            hintText: "Enter Your Blog Content here",
            hintStyle: TextStyle(fontSize: 15, color: Colors.black12)),
        style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
