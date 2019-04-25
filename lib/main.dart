import 'package:flutter/material.dart';
import 'package:flutter_new_project/random.dart';
import 'second.dart';
import 'profilescreen.dart';
import 'home.dart';
void main() => runApp(MaterialApp(
  home: Scaffold(
    body: HomeUI(),
  ),

));
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onUnknownRoute: (routeSettings) {

      },
      onGenerateRoute: (setting) {
        // profile
        //detail screen
        //post detail
        print(setting.name);
        var name = setting.name;
        var splits = name.split("/");
        switch (splits[1]) {
          case "profile":
            var profileId = splits[2];
            return MaterialPageRoute(
                builder: (context)=>SecondState()
            );
           break;
          default:
            break;
        }
      },
      //profile/21
      //["","profile","21"]
      title: 'Flutter Demo',

      home: MyStateLessWidget(),
    );
  }
}

var names = [
  "mohan",
  "kumar",
  "dhakal",
  "shreeja",
  "shrijan",
  "Shrestha",
  "Aastha",
  "Shrestha",
  "Sostika",
  "Gaudel",
  "Sagar",
  "Samal"
];

class MyStateLessWidget extends StatefulWidget {
  @override
  _MyStateLessWidgetState createState() => _MyStateLessWidgetState();
}

class _MyStateLessWidgetState extends State<MyStateLessWidget> {
  int selectedMenu = 0;

  var _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: Duration(microseconds: 300), curve: Curves.easeInOut);
            setState(() {
              selectedMenu = index;
            });
          },
          currentIndex: selectedMenu,
          fixedColor: Colors.blueAccent,
          items: [

            BottomNavigationBarItem(
                backgroundColor: Colors.red,
                icon: Icon(Icons.home),
                title: Text("Home")),
            BottomNavigationBarItem(
                backgroundColor: Colors.blueAccent,
                icon: Icon(Icons.settings),
                title: Text("Setting")),
            BottomNavigationBarItem(
                backgroundColor: Colors.greenAccent,
                icon: Icon(Icons.laptop),
                title: Text("Laptop")),
            BottomNavigationBarItem(
                backgroundColor: Colors.brown,
                icon: Icon(Icons.alarm),
                title: Text("alarm")),
          ],
        ),
        appBar: AppBar(

          title: Text("NEW APP"),
        ),
        body:Random()
    );
  }
}
