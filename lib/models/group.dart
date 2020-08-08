import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;

import 'package:smart_reading/models/book.dart';
import 'package:smart_reading/models/user.dart';

class Group {
  final int id;
  final String name;
  final String imageUrl;
  List<User> members;
  List<Book> books;
  
  Group(this.id, this.name, this.imageUrl) {
    members =  [
      saito, greg, nick
    ];
    books = [
      Constants.defaultBook,
      Constants.defaultBook2,
      Constants.defaultBook3,
      Constants.defaultBook4,
    ];
  }

  List<User> _getMembers(int id) {
    return new List<User> ();
  }

  List<Book> _getBooks(int id) {
    return new List<Book>();
  }
}
