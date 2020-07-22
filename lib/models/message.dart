import 'package:flutter/material.dart';
import 'package:smart_reading/models/user.dart';

class Message {
  final User sender;
  DateTime time;
  final String text;
  final bool isLiked;
  final bool unread;
  
  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });

  String previewMessage() {
    String content = "${sender.name}: $text";
    if (content.length > 80) {
      return content.substring(0, 77) + '...';
    }
    else {
      return content;
    }
  }

}
