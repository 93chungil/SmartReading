import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/book_info.dart';
import 'package:smart_reading/models/journal.dart';
import 'package:smart_reading/models/topic_reply.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.MAIN_BACKGROUND,
      child: ListView.builder(
        itemCount: Constants.litems.length,
        itemBuilder: (context, index) => _generateFeed(context, index),
      ),
    );
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
