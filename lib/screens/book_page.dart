import 'package:flutter/material.dart';

import 'package:smart_reading/constants.dart' as Constants;
import 'package:smart_reading/translations.dart';
import 'package:smart_reading/models/book.dart';
import 'package:smart_reading/models/user.dart';

class BookPage extends StatefulWidget {
  final Book book;
  BookPage(this.book);
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  void addToMyBooks(Book book) {
    var addbook = UserBook(book, null, book.totalPage, 0, DateTime.now(), DateTime.now());
    if (currentUser.userbooks.contains(addbook)) {
      showDialog(
        context: context,
        child: new AlertDialog(
          title: Text(Translations.of(context).text("duplicate")),
          content: Text(Translations.of(context).text("alreadyinlibrary")),
          actions: [
            new FlatButton(child: const Text("Ok"), onPressed: onDialogPressed),
          ],
        ),
      );
      return;
    }
    currentUser.userbooks.add(addbook);
    showDialog(
      context: context,
      child: new AlertDialog(
        title: Text(Translations.of(context).text("duplicate")),
        content: Text(Translations.of(context).text("alreadyinlibrary")),
        actions: [
          new FlatButton(child: const Text("Ok"), onPressed: onDialogPressed),
        ],
      ),
    );
  }
  
  void onDialogPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<dynamic> bookImage =
        widget.book.imageUrl.substring(0, 6) == "assets"
            ? AssetImage(widget.book.imageUrl)
            : NetworkImage(widget.book.imageUrl);
    return Scaffold(
      backgroundColor: Constants.MAIN_BACKGROUND,
      appBar: AppBar(
        title: Text(Translations.of(context).text("bookinfo")),
        backgroundColor: Constants.MAIN_COLOR,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  margin: EdgeInsets.only(bottom: 7.5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: bookImage, // <--- .image added here
                    ),
                  ),
                ),
                Align(
                  child: Text(
                    widget.book.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  child: Text(
                    widget.book.authors.join(', '),
                    style: TextStyle(fontSize: 14),
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              addToMyBooks(widget.book);
            },
            child: Text(Translations.of(context).text("addtomylibrary")),
          )
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.orange),
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          // ),
          // child: ListTile(
          //   leading: SizedBox(
          //     height: 200,
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(8.0),
          //       child: Image.network(
          //         widget.book.imageUrl,
          //         fit: BoxFit.fill,
          //         height: 300),
          //     ),
          //   ),
          //   title: Text(widget.book.title),
          //   subtitle: Text(widget.book.authors.join(',')),
          // ),
        ],
      ),
    );
  }
}
