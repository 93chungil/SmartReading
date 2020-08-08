library constants;

import 'package:flutter/material.dart';

// TODO Remove with database
import 'package:smart_reading/models/book.dart';
import 'package:smart_reading/models/group.dart';

const MAIN_COLOR = Colors.green;
final MAIN_BACKGROUND = Colors.amber.shade50;
const FEED_BACKGROUND = Colors.grey;

const FEED_TITLE_FONTSIZE = 18.0;
const FEED_TITLE_FONTFAMILY = "";

const FEED_CONTENT_FONTSIZE = 15.0;
const FEED_CONTENT_FONTFAMILY = "";

const APPBAR_FONTSIZE = 22.0;

const LIST_HEADER_LEFT_PADDING = 15.0;
//TODO: Move To Provider? 
const List<String> litems = ["1","2","Third","4","5","","",""];
const List<String> folders = ["All", "Favs", "Horror", "Non-fiction", "Fiction", "Essays"];

Book defaultBook = Book("Thinking Fast and Slow", ["Daniel Kahneman"], "assets/images/bookimg.jpg", new Map<String, String>());
Book defaultBook2 = Book("Thinking", ["Daniel Kahneman", "Chung il Lee"], "assets/images/bookimg.jpg", new Map<String, String>());
Book defaultBook3 = Book("Fast and Slow", ["Danny K"], "assets/images/bookimg.jpg", new Map<String, String>());
Book defaultBook4 = Book("ThinkingSlow", ["Daniel"], "assets/images/bookimg.jpg", new Map<String, String>());
Book defaultBook5 = Book("Thinking Fast", ["Kahneman"], "assets/images/bookimg.jpg", new Map<String, String>());
Book defaultBook6 = Book("Slow", ["Daniel Kahneman"], "assets/images/bookimg.jpg", new Map<String, String>());
Book defaultBook7 = Book("Fast", ["Daniel Kahneman"], "assets/images/bookimg.jpg", new Map<String, String>());
Book defaultBook8 = Book("Thinking and", ["Daniel Kahneman"], "assets/images/bookimg.jpg", new Map<String, String>());

List<Group> defaultGroups = [
    Group(0, "Chungil's Book Club", "assets/images/profileimage.png"),
    Group(1, "SmartSmart Book Club", "assets/images/profileimage.png"),
    Group(2, "Book Club", "assets/images/profileimage.png"),
    Group(3, "Smart Book Club gg", "assets/images/profileimage.png"),
    Group(4, "gg club", "assets/images/profileimage.png"),
    Group(5, "Club", "assets/images/profileimage.png"),
    Group(6, "SmartSmart", "assets/images/profileimage.png"),
    Group(7, "Chungun's Book Club", "assets/images/profileimage.png"),
    Group(8, "Mijong's Book Club", "assets/images/profileimage.png"),
    Group(9, "Hyeonggab's Book Club", "assets/images/profileimage.png"),
    Group(10, "Hyojoo's Book Club", "assets/images/profileimage.png"),
];
