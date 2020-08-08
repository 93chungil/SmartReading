import 'package:flutter/material.dart';
import 'package:smart_reading/models/book_info.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/user.dart';

class FolderPage extends StatefulWidget {
  final String foldername;
  FolderPage(this.foldername);
  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  @override
  Widget build(BuildContext context) {
    var folderBooks = currentUser.getFolderBooks(widget.foldername);
    return Scaffold(
      backgroundColor: Constants.MAIN_BACKGROUND,
      appBar: AppBar(
        title: Text(widget.foldername),
        backgroundColor: Constants.MAIN_COLOR,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(folderBooks.length, (index) => BookInfoButton(folderBooks[index])),
      )
    );
  }
}