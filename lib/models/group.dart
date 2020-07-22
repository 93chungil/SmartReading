import 'package:flutter/material.dart';

import 'package:smart_reading/models/book.dart';
import 'package:smart_reading/models/user.dart';

class Group {
  final int id;
  final String name;
  final String imageUrl;
  List<User> members;
  List<Book> books;
  
  Group(this.id, this.name, this.imageUrl);
}
