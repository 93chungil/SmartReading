import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/book_info.dart';
import 'package:smart_reading/models/user.dart';

class TopicReply {
  User user;
  DateTime write_time;
  String topic;
  String one_line;
  String extra_line;
  Book book;
  Image pic;
  
  TopicReply(this.book, this.topic, this.one_line);
}


Widget buildTopicReplyFeed(BuildContext context, int index) {
  return Card(
    color: Constants.FEED_BACKGROUND,
    child: Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/images/profileimage.png'),
            ),
            title: Text("이충일"),
            subtitle: Text("2020-05-21 11:44 PM"),
            trailing: Icon(Icons.more_horiz),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.centerLeft,
            child: Text ("빠르게 그리고 느리게 생각하는 방법에대한 논재 답변",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Constants.FEED_TITLE_FONTSIZE,
                fontFamily: Constants.FEED_TITLE_FONTFAMILY,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text("책이 정말 재밌었다. 시간 가는 줄 모르고 읽었다.",
              style: TextStyle(
                fontSize: Constants.FEED_CONTENT_FONTSIZE,
                fontFamily: Constants.FEED_CONTENT_FONTFAMILY,
              ),
            ),
          ),
          BookInfoFeed("93", "113", Constants.defaultBook),
          Divider(color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.thumb_up,
                    size: 18.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("Like"),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.mode_comment,
                    size: 18.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("Comment"),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.share,
                    size: 18.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text("Share"),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

