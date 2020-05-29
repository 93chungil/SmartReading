import 'package:flutter/material.dart';
import 'package:smart_reading/screens/grouphome.dart';
import 'package:smart_reading/screens/home.dart';
import 'package:smart_reading/screens/userhome.dart';
import 'package:smart_reading/screens/messagehome.dart';
import 'package:smart_reading/helpers/dialog_helper.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/screens/write_journal_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('똑똑해지는 독서모임'),
        backgroundColor: Constants.MAIN_COLOR,
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Main()),
            );
          },
        ),
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  final bodies = [Home(), GroupHome(), Container(color: Colors.grey,), MessageHome(), UserHome()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("똑서"),
        backgroundColor: Constants.MAIN_COLOR,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      drawer: Drawer(),
      body: bodies[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Constants.MAIN_COLOR,
          selectedItemColor: Colors.lightGreenAccent,
          unselectedItemColor: Colors.lightGreen,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text('GroupHome'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text('Messages'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('UserHome'),
            ),
          ],
          onTap: (index) {
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WriteJournalPage()),
              );
            }
            else {
              setState(() => _currentIndex = index);
            }
          }),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final books = ['Death', 'Originals', 'Thinking Fast and Slow', '관점을 디자인하다'];

  final recentbooks = ['Death', '관점을 디자인하다'];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Implement Search Result Page
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          shape: StadiumBorder(),
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentbooks
        : books.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.book),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
    );
  }
}
