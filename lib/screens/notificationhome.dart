import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/user.dart';
import 'package:smart_reading/translations.dart';
import 'package:smart_reading/models/data_search.dart';

class NotificationHome extends StatefulWidget {
  @override
  _NotificationHomeState createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome>{
  @override
  Widget build(BuildContext context) {
    // this sliver app bar is only use to hide/show the tabBar, the AppBar
    // is invisible at all times. The to the user visible AppBar is below
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).text('notifications')),
        backgroundColor: Constants.MAIN_COLOR,
      ),
      drawer: Drawer(),
      body: Container(
            color: Constants.MAIN_BACKGROUND,
            child: currentUser.showChatRooms(context),
      ),
    );
  }
}
