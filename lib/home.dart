import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/newpost.dart';
import 'package:flutter_new_project/postdetails.dart';
import 'package:flutter_new_project/random.dart';

import 'helper.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  List<BlogPost> itemList = List();
  DatabaseReference itemRef;
  var images = [
    "images/skipping.jpg",
    "images/anlella.jpg",
    "images/menworkout.jpg",
    "images/diet.jpg",
    "images/plank.jpg",
    "images/womenworkout.jpg",
    "images/benchpress.jpg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('BlogItems');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      itemList.add(BlogPost.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = itemList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      itemList[itemList.indexOf(old)] = BlogPost.fromSnapshot(event.snapshot);
    });
  }

  Widget returnFragment(int index) {
    switch (index) {
      case 0:
        return showBlogCollection();
        break;
      case 1:
        return Random();
        break;
      case 2:
        return AddNewPost();
        break;
    }
  }

  var selectedItem = 0;
  var _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Fit Nepal"),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  currentAccountPicture: Image.network(
                      "https://png.pngtree.com/svg/20170331/businessman_863430.png"),
                  accountEmail: Text("mohandkl.512@gmail.com"),
                  accountName: Text("mohan")),
              ListTile(
                onTap: () => print("printing here!"),
                title: Text("Home"),
                leading: Icon(Icons.home),
              ),
              ListTile(
                onTap: () => print("printing here!"),
                title: Text("Setting"),
                leading: Icon(Icons.settings),
              ),
              ListTile(
                onTap: () => print("printing here!"),
                title: Text("About Us"),
                leading: Icon(Icons.description),
              )
            ],
          ),
          elevation: 10,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedItem,
            fixedColor: Colors.greenAccent,
            onTap: (index) {
              _pageController.animateToPage(index,
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeInOut);
              setState(() {
                selectedItem = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text("Profile")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), title: Text("Add Post")),
            ]),
        body: PageView.builder(
          controller: _pageController,
          itemCount: 3,
          onPageChanged: (index) {
            setState(() {
              selectedItem = index;
            });
          },
          itemBuilder: (context, index) {
            return returnFragment(index);
          },
        ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 3.0,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {},
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(50.0),
            child: TextField(
              style: TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration.collapsed(
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black26,
                ),
                hintText: "Search The Post You Like",
              ),
              keyboardAppearance: Brightness.light,
            ),
          ),
        ),
      ),
    );
  }

  Widget recentPosts() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Recent Posts",
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 2,
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage("images/anlella.jpg"),
                  width: 100,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage("images/diet.png"),
                  width: 100,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage("images/plank.jpg"),
                  width: 100,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage("images/womenworkout.jpg"),
                  width: 100,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage("images/benchpress.jpg"),
                  width: 100,
                  height: 80,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 2,
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }

  Widget showBlogCollection() {
    return Container(
      child: Column(
        children: <Widget>[
          searchBar(),
          recentPosts(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "All Posts",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Flexible(
            child: FirebaseAnimatedList(
              query: itemRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDetails(
                                  itemList[index].title,
                                  itemList[index].content,
                                  images[index])),
                        ),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 2.0,
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image(
                          image: AssetImage(images[index]),
                          height: 100,
                          width: 100,
                        ),
                        title: Text(
                          itemList[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 80,
                            child: Text(
                              itemList[index].content,
                              maxLines: 3,
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
