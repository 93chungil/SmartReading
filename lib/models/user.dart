import 'dart:collection';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:smart_reading/models/book.dart';
import 'package:smart_reading/models/group.dart';
import 'package:smart_reading/models/message_room.dart';
import 'package:smart_reading/screens/message_page.dart';
import 'package:smart_reading/constants.dart' as Constants;

class User {
  final int id;
  String name;
  String imageUrl;
  Map<int, MessageRoom> rooms;
  ChatUser chatUser;
  List<User> followers;
  List<User> following;
  List<Group> groups;
  ListQueue<Group> recentgroups = new ListQueue<Group>(10);

  List<UserBook> userbooks = [
    UserBook(Constants.defaultBook, null, 380, 130,
        DateTime(2020, 01, 20, 3, 50, 0), DateTime(2020, 01, 20, 3, 50, 0)),
    UserBook(Constants.defaultBook2, null, 38, 12,
        DateTime(2020, 2, 20, 12, 20, 0), DateTime(2020, 2, 20, 12, 20, 0)),
    UserBook(Constants.defaultBook3, null, 80, 60,
        DateTime(2020, 3, 20, 13, 50, 0), DateTime(2020, 3, 20, 13, 50, 0)),
    UserBook(Constants.defaultBook4, null, 830, 120,
        DateTime(2019, 3, 20, 20, 50, 60), DateTime(2019, 3, 20, 20, 50, 60)),
    UserBook(Constants.defaultBook5, null, 500, 430,
        DateTime(2020, 4, 20, 18, 50, 30), DateTime(2020, 4, 20, 18, 50, 30)),
    UserBook(Constants.defaultBook6, null, 100, 60,
        DateTime(2019, 12, 20, 6, 50, 30), DateTime(2019, 12, 20, 18, 50, 30)),
    UserBook(Constants.defaultBook7, null, 60, 60,
        DateTime(2019, 6, 20, 3, 20, 30), DateTime(2019, 7, 31, 3, 50, 30)),
    UserBook(Constants.defaultBook8, null, 780, 750,
        DateTime(2019, 1, 20, 15, 50, 30), DateTime(2020, 01, 20, 3, 50, 30)),
  ];

  int getFollwers() {
    followers = [saito, greg];
    return followers.length;
  }

  int getFollowing() {
    following = [saito, nick, greg];
    return following.length;
  }

  int getGroups() {
    groups = Constants.defaultGroups;
    return groups.length;
  }

  List<UserBook> getFolderBooks(String foldername) {
    List<UserBook> returnlist = [];
    if (foldername == 'All') {
      return userbooks;
    }

    for (var i = 0; i < userbooks.length; i++) {
      if (userbooks[i].location == foldername) {
        returnlist.add(userbooks[i]);
      }
    }

    return returnlist;
  }

  Map<int, MessageRoom> getChatRooms() {
    return {
      0: MessageRoom(0, "", [greg]),
      1: MessageRoom(1, "Chat with Saito", [saito]),
      2: MessageRoom(2, null, [nick]),
      3: MessageRoom(3, "", [greg, saito, nick]),
      4: MessageRoom(4, "everyone", [greg, saito, nick]),
    };
  }

  Widget showChatRooms(BuildContext context) {
    rooms = getChatRooms();
    var formatter = DateFormat.jm();
    // return new ListView.builder(
    //   itemCount: rooms.length,
    //   itemBuilder: (context, index) {
    //     var curkey = rooms.keys.elementAt(index);
    //     var curroom = rooms[curkey];
    //     return SizedBox(
    //       height: 80.0,
    //       child: Card(
    //         color: Constants.FEED_BACKGROUND,
    //         child: ListTile(
    //           leading: CircleAvatar(
    //             radius: 20.0,
    //             backgroundImage: curroom.image.image,
    //           ),
    //           title: Text('${curroom.recentMessage.previewMessage()}'),
    //           trailing: Text(formatter.format(curroom.recentMessage.time)),
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => MessagePage(curroom.id),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     );
    //   },
    // );
    return Container(
      decoration: BoxDecoration(
        color: Constants.MAIN_BACKGROUND,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (BuildContext context, int index) {
            final int curkey = rooms.keys.elementAt(index);
            final MessageRoom curroom = rooms[curkey];
            final ChatMessage recentChat = curroom.recentMessage;
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagePage(curroom.id),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: recentChat.customProperties['unread']
                      ? Color(0xFFFFEFEE)
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: curroom.image.image,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              curroom.name,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                recentChat.text,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          formatter.format(curroom.recentMessage.createdAt),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        recentChat.customProperties['unread']
                            ? Container(
                                width: 40.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'NEW',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Text(''),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  User(
    this.id,
    this.name,
    this.imageUrl,
  ) {
    chatUser = ChatUser(
        uid: this.id.toString(), name: this.name, avatar: this.imageUrl);
  }
}

User currentUser;

final User saito = User(1, 'Saito', 'assets/images/saito.jpg');

final User greg = User(2, 'Greg', 'assets/images/greg.jpg');

final User nick = User(3, 'Nick', 'assets/images/nick.jpg');
