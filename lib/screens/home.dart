import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/book_info.dart';
import 'package:smart_reading/models/journal.dart';
import 'package:smart_reading/models/topic_reply.dart';
import 'package:smart_reading/translations.dart';
import 'package:smart_reading/models/data_search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: Container(
      color: Constants.MAIN_BACKGROUND,
      child: ListView.builder(
        itemCount: Constants.litems.length,
        itemBuilder: (context, index) => _generateFeed(context, index),
      ),
    ),);
  }
}

Widget _generateFeed(BuildContext context, int index) {
  if (index % 2 == 0) {
    return buildTopicReplyFeed(context, index);
  }
  else {
    return buildReadingJournalFeed(context, index);
  }
}
