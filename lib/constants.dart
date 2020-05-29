library constants;

import 'package:flutter/material.dart';
import 'package:smart_reading/models/book_info.dart';

const MAIN_COLOR = Colors.green;
const MAIN_BACKGROUND = Colors.white;
const FEED_BACKGROUND = Colors.grey;

const FEED_TITLE_FONTSIZE = 18.0;
const FEED_TITLE_FONTFAMILY = "";

const FEED_CONTENT_FONTSIZE = 15.0;
const FEED_CONTENT_FONTFAMILY = "";

const LIST_HEADER_LEFT_PADDING = 15.0;
//TODO: Move To Provider? 
const List<String> litems = ["1","2","Third","4","5","","",""];
const List<String> folders = ["All", "Favs", "Horror", "Non-fiction", "Fiction", "Essays"];

Book defaultBook = Book("Thinking Fast and Slow", ["Daniel Kahneman"], Image.asset("assets/images/bookimg.jpg"));