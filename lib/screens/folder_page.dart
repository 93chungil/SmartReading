import 'package:flutter/material.dart';
import 'package:smart_reading/models/book_info.dart';
import 'package:smart_reading/constants.dart' as Constants;

class FolderPage extends StatefulWidget {
  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.MAIN_BACKGROUND,
      appBar: AppBar(
        title: Text('똑똑해지는 독서모임'),
        backgroundColor: Constants.MAIN_COLOR,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) => BookInfoButton(Constants.defaultBook)),
      )
    );
  }
}