import 'package:flutter/material.dart';

class SecondState extends StatefulWidget {
  @override
  _SecondStateState createState() => _SecondStateState();
}

class _SecondStateState extends State<SecondState> {
  var name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Second Screen"),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Name",
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                RaisedButton(
                  child: Text("Done"),
                  onPressed: () {
                    Navigator.pop(context, name);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
