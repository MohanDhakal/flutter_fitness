import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostDetails extends StatefulWidget {
  var title, content, imageUri;

  PostDetails(this.title, this.content, this.imageUri);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  Color _heartColor = Colors.black26;
  Color _commentColor = Colors.black26;
  Color _shareColor = Colors.black26;
  int likeCount=100,commentCount=100,shareCount=100;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("Post Detail"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Colors.black38, width: 2),
              ),
              child: Column(
                children: <Widget>[
                  Image(image: AssetImage(widget.imageUri)),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20),
                        child: Text(
                          "2017/0ct/22",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100.0, top: 20),
                        child: Text(
                          "Posted By: Mohan Kumar Dhakal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top:10),
                    height: 2,
                    decoration: BoxDecoration(color: Colors.black12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.content,
                    ),
                  ),
                  Container(
                    height: 2,
                    decoration: BoxDecoration(color: Colors.black12),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:30.0),
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    likeCount= _heartColor==Colors.black26? ++likeCount:--likeCount;
                                    _heartColor = _heartColor == Colors.black26
                                        ? Colors.purple
                                        : Colors.black26;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.heart,
                                  color: _heartColor,
                                ),
                              ),
                              Text(
                                likeCount.toString()
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:50.0),
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    commentCount= _commentColor==Colors.black26? ++commentCount:--commentCount;
                                    _commentColor = _commentColor == Colors.black26
                                        ? Colors.blue
                                        : Colors.black26;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.comment,
                                  color: _commentColor,
                                ),
                              ),
                              Text(commentCount.toString())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:50.0),
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    shareCount=_shareColor ==Colors.black26? ++shareCount:--shareCount;
                                    _shareColor = _shareColor == Colors.black26
                                        ? Colors.blue
                                        : Colors.black26;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.share,
                                  color: _shareColor,
                                ),
                              ),
                              Text(shareCount.toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
