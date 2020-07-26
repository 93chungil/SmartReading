import 'package:flutter/material.dart';

import 'package:smart_reading/models/book_info.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/group.dart';
import 'package:smart_reading/models/user.dart';
import 'package:smart_reading/screens/folder_page.dart';
import 'package:smart_reading/translations.dart';
import 'package:smart_reading/models/data_search.dart';

class GroupPage extends StatefulWidget {
  final Group group;
  GroupPage(this.group);
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.group.name,
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
      backgroundColor: Constants.MAIN_BACKGROUND,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        image: DecorationImage(
                            image: widget.group.imageUrl.isEmpty
                                ? AssetImage('assets/images/nick.jpg')
                                : AssetImage(widget.group
                                    .imageUrl), // TODO Change to NetworkImage
                            fit: BoxFit.cover),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.group.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0)),
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 20.0, right: 20.0),
                          child: Container(
                            width: 260.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                              child: Text('Edit Profile',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => EditProfileScreen(
                          //             photoUrl: _user.photoUrl,
                          //             email: _user.email,
                          //             bio: _user.bio,
                          //             name: _user.displayName,
                          //             phone: _user.phone))));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: detailsWidget(
                        currentUser.userbooks.length.toString(), 'books'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: detailsWidget(
                        currentUser.getGroups().toString(), 'groups'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: detailsWidget(
                        currentUser.getFollwers().toString(), 'followers'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: detailsWidget(
                        currentUser.getFollowing().toString(), 'following'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10.0),
              // child: currentUser..bio.isNotEmpty ? Text(_user.bio) : Container(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    EdgeInsets.only(left: Constants.LIST_HEADER_LEFT_PADDING),
                child: Text(
                  Translations.of(context).text('recentbooks'),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            Container(
              height: 160,
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: _buildRecentBooks(context),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    EdgeInsets.only(left: Constants.LIST_HEADER_LEFT_PADDING),
                child: Text(
                  Translations.of(context).text('folders'),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            _buildCategory(context, 3),
          ],
        ),
      ),
    );
  }

  Widget detailsWidget(String count, String label) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Text(count,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black)),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(label,
                style: TextStyle(fontSize: 16.0, color: Colors.grey)),
          )
        ],
      ),
      onTap: () {},
    );
  }
}

List<Widget> _buildRecentBooks(BuildContext context) {
  // todo add see all button that leads to All folder sorted by access date
  currentUser.userbooks.sort((b, a) => a.modified_at.compareTo(b.modified_at));

  var recentBooks = currentUser.userbooks.sublist(0, 5);
  List<Widget> returnList = [];
  for (var book in recentBooks) {
    returnList.add(BookInfoButton(book));
  }
  return returnList;
}

Widget _buildCategory(BuildContext context, int colcount) {
  List<TableRow> rows = [];
  var chunks = [];

  for (var i = 0; i < Constants.folders.length; i += colcount) {
    if (i + colcount >= Constants.folders.length) {
      chunks.add(Constants.folders.sublist(i, Constants.folders.length));
    } else {
      chunks.add(Constants.folders.sublist(i, i + colcount));
    }
  }

  for (var i = 0; i < chunks.length; i++) {
    TableRow temprow;
    if (chunks[i].length != 3) {
      var curlist = List.generate(chunks[i].length,
          (index) => _buildCategoryFolder(context, chunks[i][index]));
      while (curlist.length < 3) {
        curlist.add(Container());
      }
      temprow = TableRow(children: curlist);
    } else {
      temprow = TableRow(
        children: List.generate(chunks[i].length,
            (index) => _buildCategoryFolder(context, chunks[i][index])),
      );
    }
    rows.add(temprow);
  }

  return Table(
    children: rows,
  );
}

Widget _buildCategoryFolder(BuildContext context, String foldername) {
  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 10.0,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: new Icon(Icons.folder),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FolderPage(foldername)),
          ),
        ),
        Text(foldername),
      ],
    ),
  );
}
