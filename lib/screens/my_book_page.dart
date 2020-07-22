import 'package:flutter/material.dart';
import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/models/book.dart';
import 'package:smart_reading/models/journal.dart';
import 'package:smart_reading/models/topic_reply.dart';
import 'package:smart_reading/screens/book_page.dart';
import 'package:smart_reading/translations.dart';

class MyBookPage extends StatefulWidget {
  final UserBook userBook;
  MyBookPage(this.userBook);
  @override
  _MyBookPageState createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> with SingleTickerProviderStateMixin  {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // this sliver app bar is only use to hide/show the tabBar, the AppBar
    // is invisible at all times. The to the user visible AppBar is below
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  primary: true,
                  floating: true,
                  backgroundColor: Constants.MAIN_COLOR,//.withOpacity(0.3),
                  snap: true,
                  pinned: false,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          Translations.of(context).text('journals'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          Translations.of(context).text('articles'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    controller: _tabController,
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Container(
                  color: Constants.MAIN_BACKGROUND,
                  child: ListView.builder(
                    itemCount: Constants.litems.length,
                    itemBuilder: (context, index) => buildReadingJournalFeed(context, index),
                  ),
                ),
                Container(
                  color: Constants.MAIN_BACKGROUND,
                  child: ListView.builder(
                    itemCount: Constants.litems.length,
                    itemBuilder: (context, index) => buildTopicReplyFeed(context, index),
                  ),
                ),
              ],
              controller: _tabController,
            ),
          ),
          // Here is the AppBar the user actually sees. The SliverAppBar
          // above will slide the TabBar underneath this one. 
          // by using SafeArea it will.
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              child: SafeArea(
                top: false,
                child: AppBar(
                  backgroundColor: Constants.MAIN_COLOR,
//                iconTheme: IconThemeData(
//                  color: Colors.red, //change your color here
//                ),
                  automaticallyImplyLeading: true,
                  elevation: 0,
                  title: Text(widget.userBook.book.title,),
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.book),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookPage(widget.userBook.book)),
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
