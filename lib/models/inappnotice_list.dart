import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_reading/models/inappnotice.dart';

class InAppNoticeList extends StatefulWidget {

  //NotificationList({Key key, this.notifications}) : super(key: key);

  final List<InAppNotice> notifications = [
    new InAppNotice("abcde", 1, "Journal: Thinking Fast and Slow", DateTime.now()),
    new InAppNotice("efgh", 1, "Articl: Thinking Fast and Slow",  DateTime.now()),
    new InAppNotice("ijk", 2, "Journal: Thinking Fast and Slow",DateTime.now()),
    new InAppNotice("l123", 2, "Comment: I love this book",  DateTime.now()),
    new InAppNotice("m456", 3, "",  DateTime.now()),
    new InAppNotice("n789", 3, "",  DateTime.now()),
    new InAppNotice("n789", 4, "This is not supposed to be printed",  DateTime.now())
  ];

  @override
  _InAppNoticeListState createState() => new _InAppNoticeListState();
}

class _InAppNoticeListState extends State<InAppNoticeList> {

  @override
  Widget build(BuildContext context) {
    return _buildInAppNoticeList(context, widget.notifications);
  }

  ListView _buildInAppNoticeList(context, List<InAppNotice> messages) {
    return new ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        var s = messages[index];
        return ListTile(
          leading: s.getTypeIcon(),
          title: Text(s.getContent()), 
        );
      },
    );
  }

}