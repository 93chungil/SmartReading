import 'package:flutter/material.dart';
import 'package:smart_reading/screens/my_book_page.dart';
import 'package:smart_reading/models/book.dart';

class BookInfoFeed extends StatelessWidget {
  final String from;
  final String to;
  final Book book;
  BookInfoFeed(this.from, this.to, this.book);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.orange),
      //   borderRadius: BorderRadius.all(Radius.circular(20)),
      // ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(book.imageUrl),
        ),
        title: Text(book.title),
        subtitle: Text(book.authors.join(',')),
        trailing: Text('$from - $to'),
      ),
    );
  }
}

class BookInfoButton extends StatelessWidget {
  final UserBook userBook;
  BookInfoButton(this.userBook);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(bottom: 7.5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(userBook.book.imageUrl), // <--- .image added here
                  ),
                ),
              ),
              onTap: () {
                userBook.modified_at = DateTime.now();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBookPage(userBook)),
                );
              },
            ),
          ),
          Text(
            userBook.book.title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            child: Text(
              userBook.book.authors.join(','),
              style: TextStyle(fontSize: 10),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
