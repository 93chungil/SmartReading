import 'package:flutter/material.dart';

class InAppNotice {
  String from;
  int type; //1 for like, 2 for comment, 3 for follow
  String content;
  String sourceLink;
  int status;
  DateTime writeTime;
  
  InAppNotice(this.from, this.type, this.content, this.writeTime);
  
  String getContent() {
    switch(type) {
      case 1:
        return "${this.from} Liked your ${this.content}";
      case 2:
        return "${this.from} Commented on your ${this.content}";
      case 3:
        return "${this.from} Started Following You";
      default:
        return "Not found in type ${this.type}";
    }
  }

  Icon getTypeIcon() {
    switch(type) {
      case 1:
        return Icon(Icons.thumb_up);
      case 2:
        return Icon(Icons.comment);
      case 3:
        return Icon(Icons.person);
      default:
        return Icon(Icons.adjust);
    }
  }
}
