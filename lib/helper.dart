import 'package:firebase_database/firebase_database.dart';
class BlogPost {
  String key,_title, _content;
  BlogPost(this._title, this._content);
  String get title => _title;

  set title(String value) {
    _title = value;
  }

  get content => _content;

  set content(value) {
    _content = value;
  }
  BlogPost.fromSnapshot(DataSnapshot snapshot)
      :_title = snapshot.value['title'],
       _content = snapshot.value['body'];

  toJson() {
    return {
      "title": _title,
      "body": content,
    };
  }
}
