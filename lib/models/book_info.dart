import 'package:flutter/material.dart';
import 'package:smart_reading/screens/my_book_page.dart';

class Book {
  String title;
  String subtitle;
  List<String> authors;
  String publisher;
  DateTime publish_date;
  Map<String, String> industry_identifiers;
  Image cover;

  Book(this.title, this.authors, this.cover);
}

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
          child: book.cover,
        ),
        title: Text(book.title),
        subtitle: Text(book.authors.join(',')),
        trailing: Text('$from - $to'),
      ),
    );
  }
}

class BookInfoButton extends StatelessWidget {
  final Book book;
  BookInfoButton(this.book);

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
                    image: book.cover.image, // <--- .image added here
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBookPage()),
                );
              },
            ),
          ),
          Text(
            book.title,
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
              book.authors.join(','),
              style: TextStyle(fontSize: 10),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
