import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// TODO REMOVE WITH SERVER
import 'package:smart_reading/models/user.dart';

import 'package:smart_reading/screens/grouphome.dart';
import 'package:smart_reading/screens/home.dart';
import 'package:smart_reading/screens/userhome.dart';
import 'package:smart_reading/screens/messagehome.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/screens/write_journal_page.dart';
import 'package:smart_reading/login.dart';
import 'package:smart_reading/register.dart';
import 'package:smart_reading/translations.dart';
import 'package:smart_reading/application.dart';

void main() {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool isLogged = (prefs.getBool('isLogged') ?? false) ;

  // var home;
  // if(isLogged)
  //   home = ProfileRoute();
  // else
  //   home = LoginRoute();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecifiedLocalizationsDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();
    _localeOverrideDelegate =
        new SpecifiedLocalizationsDelegate(new Locale("ko", ''));
    // TODO REMOVE WITH SERVER
    currentUser = User(0, 'abcd', "assets/images/profileimage.png");
  }

  onLocaleChange(Locale l) {
    setState(() {
      _localeOverrideDelegate = new SpecifiedLocalizationsDelegate(l);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      // home: Login(),
      home: Main(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/main': (context) => Main(),
      },
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;

  final bodies = [
    Home(),
    GroupHome(),
    Container(
      color: Colors.grey,
    ),
    MessageHome(),
    UserHome()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Constants.MAIN_COLOR,
          selectedItemColor: Colors.lightGreenAccent,
          unselectedItemColor: Colors.lightGreen,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(''),
            ),
          ],
          onTap: (index) {
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WriteJournalPage()),
              );
            } else {
              setState(() => _currentIndex = index);
            }
          }),
    );
  }
}
