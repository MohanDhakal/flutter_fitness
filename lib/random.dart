import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_new_project/new.dart';
import 'package:flutter_new_project/user.dart';
import 'package:http/http.dart';

class Random extends StatefulWidget {
  @override
  _RandomState createState() => _RandomState();
}

class _RandomState extends State<Random> {
  var name, password;
  final myGlobalKey = GlobalKey<FormState>();

  String errorMessage = "Error Message here";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: myGlobalKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Text(errorMessage),
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
                    sendtoServer();
                  },
                  child: Text(
                    "Send to Server",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          return value.isEmpty ? "Name Can't be empty" : null;
        },
        onSaved: (value) {
          name = value;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          hintText: "Enter Your Name Here",
          hintStyle: TextStyle(fontSize: 15, color: Colors.black12),
          labelText: "Name",
        ),
        style: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  Widget ContentField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          return value.isEmpty ? "Enter Your Password" : null;
        },
        onSaved: (value) {
          password = value;
        },
        decoration: InputDecoration(
            labelText: "password",
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            hintText: "Enter Password",
            hintStyle: TextStyle(fontSize: 15, color: Colors.black12)),
        style: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  sendtoServer() async {
    final FormState form = myGlobalKey.currentState;
    Map<String, dynamic> body = {
      "username": name,
      "password": password,
    };
    if (form.validate()) {
      form.save();
      try {
        Response response =
            await post('http://flutter.sochware.com/api/login', body: body);
        print("status code=${response.statusCode}");
        var jsonData = json.decode(response.body);
        if (response.statusCode != 200) {
          setState(() {
            errorMessage = jsonData["message"];
          });
        } else {
          User user = User.fromJson(jsonData['payload'][0]);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NextPage(user)));
        }
      } catch (exception) {
        print(exception);
        if (exception is SocketException) {
          errorMessage = "Internet Not Available";
        }
      }
    }
  }
}
