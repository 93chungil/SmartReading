import 'package:flutter/material.dart';
import 'package:smart_reading/screens/write_journal_page.dart';
import 'package:smart_reading/screens/write_reply_page.dart';

class What2WriteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
    child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        color: Colors.teal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.all(16.0),
              child: Text('독서기록'),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WriteJournalPage())
                );
              }
            ),
            RaisedButton(
              padding: EdgeInsets.all(16.0),
              child: Text('논재답변'),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WriteReplyPage())
                );
              }
            ),
          ],
        ),
      ),
    ),
  );
}
