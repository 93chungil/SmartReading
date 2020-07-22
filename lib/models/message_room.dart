import 'dart:ui';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:smart_reading/models/user.dart';
import 'package:smart_reading/models/message.dart';

class MessageRoom {
  final int id;
  String name;
  List<User> members;
  Image image;
  ChatMessage recentMessage;
  List<ChatMessage> messages = List<ChatMessage>();

  MessageRoom(this.id, String name, List<User> members) {
    if (name == "" || name == null) {
      if (members.length > 1) {
        List<String> membernames = [];
        for(int i = 0; i < members.length; i++) {
          membernames.add(members[i].name);
        }
        this.name = membernames.join(", ");
      }
      else if (members.length == 1) {
        this.name = members[0].name;
      }
      else {
        this.name = "Untitled";
      }
    }
    else {
      this.name = name;
    }
    this.members = members;
    this.messages = loadMessages();
    this.messages.sort((a,b) {
      var adate = a.createdAt;
      var bdate = b.createdAt;
      return adate.compareTo(bdate); //to get the order other way just switch `adate & bdate`
    });
    this.recentMessage = this.messages[0];
    this.image = Image.asset(members[0].imageUrl);
  }

  List<ChatMessage> loadMessages() {
    switch(id) {
      case 0: 
        return [
          ChatMessage(
            user: greg.chatUser,
            createdAt: DateTime(2020,06,16,2,0,0),
            text: "93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,2,1,0,0),
            text: "I know right?",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,2,1,0,200),
            text: "He is definitely a king",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: greg.chatUser,
            createdAt: DateTime(2020,06,16,2,1,1,200),
            text: "Greg really really thinks 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,3,3,0,200),
            text:
                "Saito really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
        ];
      case 1:
        return [
          ChatMessage(
            user: saito.chatUser,
            createdAt: DateTime(2020,06,16,2,0,0),
            text: "93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,2,1,0,0),
            text: "I know right?",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,2,1,0,200),
            text: "He is definitely a king",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: saito.chatUser,
            createdAt: DateTime(2020,06,16,2,1,1,200),
            text: "Greg really really thinks 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,3,3,0,200),
            text:
                "Saito really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
        ];
      case 2:
        return [
          ChatMessage(
            user: nick.chatUser,
            createdAt: DateTime(2020,06,16,2,0,0),
            text: "93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,2,1,0,0),
            text: "I know right?",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,2,1,0,200),
            text: "He is definitely a king",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: nick.chatUser,
            createdAt: DateTime(2020,06,16,2,1,1,200),
            text: "Greg really really thinks 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,3,3,0,200),
            text:
                "Saito really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
        ];
      case 3:
        return [
          ChatMessage(
            user: greg.chatUser,
            createdAt: DateTime(2020,06,16,3,3,0,200),
            text: "93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: saito.chatUser,
            createdAt: DateTime(2020,06,16,4,3,0,200),
            text: "Saito thinks 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: nick.chatUser,
            createdAt: DateTime(2020,06,16,5,3,0,200),
            text: "Nick really thinks 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: greg.chatUser,
            createdAt: DateTime(2020,06,16,6,3,0,200),
            text: "Greg really really thinks 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: saito.chatUser,
            createdAt: DateTime(2020,06,16,3,3,31,000),
            text:
                "Saito really do",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: saito.chatUser,
            createdAt: DateTime(2020,06,16,3,3,30,200),
            text:
                "Saito really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really 93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: nick.chatUser,
            createdAt: DateTime(2020,06,16,3,30,0,200),
            text: "93chungil is the king of the world",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,7,3,0,200),
            text: "I think so too!",
            customProperties: {"isLiked": false, "unread": false},
          ),
        ];
      case 4:
        return [
          ChatMessage(
            user: greg.chatUser,
            createdAt: DateTime(2020,06,16,3,3,0,200),
            text: "93chungil is the king of the world 44444",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: saito.chatUser,
            createdAt: DateTime(2020,06,16,4,3,0,200),
            text: "Saito thinks 93chungil is the king of the world 44444",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: nick.chatUser,
            createdAt: DateTime(2020,06,16,5,3,0,200),
            text: "Nick really thinks 93chungil is the king of the world 44444",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: greg.chatUser,
            createdAt: DateTime(2020,06,16,6,3,0,200),
            text: "Greg really really thinks 93chungil is the king of the world 44444",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: saito.chatUser,
            createdAt: DateTime(2020,06,16,3,3,30,200),
            text:
                "Saito really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really  really really 93chungil is the king of the world 44444",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: nick.chatUser,
            createdAt: DateTime(2020,06,16,3,30,0,200),
            text: "93chungil is the king of the world 44444",
            customProperties: {"isLiked": false, "unread": false},
          ),
          ChatMessage(
            user: currentUser.chatUser,
            createdAt: DateTime(2020,06,16,7,3,0,200),
            text: "I think so too! 44444",
            customProperties: {"isLiked": false, "unread": false},
          ),
        ];
      default:
        return [];
    }
  }
}
