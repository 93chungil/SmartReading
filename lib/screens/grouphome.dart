import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;

class GroupHome extends StatefulWidget {
  @override
  _GroupHomeState createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 120,
              child: ListView.builder(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: Constants.litems.length,
                itemBuilder: (context, index) =>
                    _buildGroupLinkTile(context, index),
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
            Column(
              children: List.generate(
                Constants.litems.length + 5,
                (index) => _buildGroupLinkLine(context, index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildGroupLinkLine(BuildContext context, int index) {
  return new ListTile(
    leading: CircleAvatar(
      radius: 20.0,
      backgroundImage: AssetImage('assets/images/profileimage.png'),
    ),
    title: Text("Chungil's Book Club"),
  );
}

Widget _buildGroupLinkTile(BuildContext context, int index) {
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
              image: AssetImage('assets/images/profileimage.png'),
              child: InkWell(
                onTap: null,
              ),
            ),
          ),
        ),
        Text(
          "Chungil's Book Club",
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
