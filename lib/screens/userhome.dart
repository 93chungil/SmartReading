import 'package:flutter/material.dart';
import 'package:smart_reading/models/book_info.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/screens/folder_page.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.MAIN_BACKGROUND,
      body: SingleChildScrollView( 
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.only(left: Constants.LIST_HEADER_LEFT_PADDING),
                child: Text("Recent Books",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            Container(
              height: 160,
              child: ListView.builder(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: Constants.litems.length,
                itemBuilder: (context, index) => _buildRecentBooks(context, index),
              ),
            ),
            Divider(color: Colors.grey),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: EdgeInsets.only(left: Constants.LIST_HEADER_LEFT_PADDING),
                  child: Text("Folders",
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
}

Widget _buildRecentBooks(BuildContext context, int index) {
  return BookInfoButton(Constants.defaultBook);
}

Widget _buildCategory(BuildContext context, int colcount) {
  List<TableRow> rows = [];
  var chunks = [];

  for (var i = 0; i < Constants.folders.length; i += colcount) {
    if (i + colcount >= Constants.folders.length) {
      chunks.add(Constants.folders.sublist(i, Constants.folders.length));
    }
    else {
      chunks.add(Constants.folders.sublist(i, i+colcount));
    }
  }

  for (var i = 0; i < chunks.length; i++) {
    TableRow temprow;
    if (chunks[i].length != 3) {
      var curlist = List.generate(chunks[i].length, (index) => _buildCategoryFolder(context, chunks[i][index]));
      while (curlist.length < 3) {
        curlist.add(Container());
      }
      temprow = TableRow(children: curlist);
    }
    else {
      temprow = TableRow(children: List.generate(chunks[i].length, (index) => _buildCategoryFolder(context, chunks[i][index])),);
    }
    rows.add(temprow);
  }

  return Table(children: rows,);
}

Widget _buildCategoryFolder(BuildContext context, String foldername) {
  return Container( 
    padding: EdgeInsets.symmetric(vertical: 10.0,),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: new Icon(Icons.folder),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FolderPage()),
          ),
        ),
        Text(foldername),
      ],
    ),
  );
}