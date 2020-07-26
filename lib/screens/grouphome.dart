import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/group.dart';
import 'package:smart_reading/models/user.dart';
import 'package:smart_reading/screens/group_page.dart';
import 'package:smart_reading/translations.dart';
import 'package:smart_reading/models/data_search.dart';

class GroupHome extends StatefulWidget {
  @override
  _GroupHomeState createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  double recentBookHeight = currentUser.recentgroups.length > 0 ? 120 : 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translations.of(context).text('title'),
          style: TextStyle(
            fontSize: Constants.APPBAR_FONTSIZE,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      backgroundColor: Constants.MAIN_BACKGROUND,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    EdgeInsets.only(left: Constants.LIST_HEADER_LEFT_PADDING),
                child: Text(
                  "Recently Visited Book Clubs",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            Container(
              height: recentBookHeight,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: _buildRecentBookClubs(context),
              ),
            ),
            Divider(color: Colors.grey),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    EdgeInsets.only(left: Constants.LIST_HEADER_LEFT_PADDING),
                child: Text(
                  "My Book Clubs",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            Column(children: _buildBookClubList(context)),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildRecentBookClubs(BuildContext context) {
  List<Widget> returnList = [];
  for (var group in currentUser.recentgroups) {
    returnList.add(_buildGroupLinkTile(context, group));
  }
  return returnList;
}

List<Widget> _buildBookClubList(BuildContext context) {
  List<Widget> returnList = [];
  for (var group in currentUser.groups) {
    returnList.add(_buildGroupLinkLine(context, group));
  }
  return returnList;
}

Widget _buildGroupLinkLine(BuildContext context, Group group) {
  return new ListTile(
    leading: CircleAvatar(
      radius: 20.0,
      backgroundImage: AssetImage(group.imageUrl),
    ),
    title: Text(group.name),
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GroupPage(group)),
    ),
  );
}

Widget _buildGroupLinkTile(BuildContext context, Group group) {
  return new Container(
    height: 100,
    width: 80,
    child: Column(
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          margin: EdgeInsets.all(5.0),
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Ink.image(
              image: AssetImage(group.imageUrl),
              child: InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupPage(group)),
                      )),
            ),
          ),
        ),
        Text(
          group.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    ),
  );
}
