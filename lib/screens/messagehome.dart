import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/inappnotice_list.dart';
import 'package:smart_reading/translations.dart';
import 'package:smart_reading/models/user.dart';

class MessageHome extends StatefulWidget {
  @override
  _MessageHomeState createState() => _MessageHomeState();
}

class _MessageHomeState extends State<MessageHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // this sliver app bar is only use to hide/show the tabBar, the AppBar
    // is invisible at all times. The to the user visible AppBar is below
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translations.of(context).text('title'),
          style: TextStyle(
              fontSize: Constants.APPBAR_FONTSIZE,
              fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text(
                Translations.of(context).text('messages'),
                textAlign: TextAlign.center,
              ),
            ),
            Tab(
              child: Text(
                Translations.of(context).text('inappnotice'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          controller: _tabController,
        ),
        backgroundColor: Constants.MAIN_COLOR,
      ),
      drawer: Drawer(),
      body: TabBarView(
        children: [
          currentUser.showChatRooms(context),
          Container(
            color: Constants.MAIN_BACKGROUND,
            child: InAppNoticeList(),
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
