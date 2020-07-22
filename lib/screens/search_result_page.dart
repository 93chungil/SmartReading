import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:smart_reading/models/book.dart';
import 'package:smart_reading/screens/book_page.dart';

class SearchResultPage extends StatefulWidget {
  final String query;
  SearchResultPage(this.query);

  @override
  _SearchResultStatePage createState() => _SearchResultStatePage();
}

class _SearchResultStatePage extends State<SearchResultPage> {
  Future<List<Book>> _googleResults;

  @override
  void initState() {
    _googleResults = _searchGoogleBooks();
    super.initState();
  }

  Future<List<Book>> _searchGoogleBooks() async {
    http.Response response;
    var url = "https://www.googleapis.com/books/v1/volumes?q=" +
        widget.query +
        "&maxResults=10";
    print(url);

    try {
      response = await http.get(url);
      print(response);
      if (response.statusCode == 200) {
        List<Book> returnList = new List<Book>();

        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (!jsonResponse.containsKey('items')) {
          return returnList;
        }
        List<dynamic> allBooks = jsonResponse['items'];

        for (var i = 0; i < allBooks.length; i++) {
          Map<String, dynamic> curBook = allBooks[i];
          if (!curBook.containsKey('volumeInfo')) {
            continue;
          }

          Map<String, dynamic> curVolume = curBook['volumeInfo'];

          if (!curVolume.containsKey("authors")) {
            continue;
          }

          if (!curVolume.containsKey("title")) {
            continue;
          }

          if (!curVolume.containsKey("imageLinks")) {
            continue;
          }

          if (!curVolume.containsKey('industryIdentifiers')) {
            continue;
          }

          Map<String, dynamic> imageLinks = curVolume['imageLinks'];

          if (!imageLinks.containsKey('thumbnail')) {
            continue;
          }

          List<dynamic> identifiers = curVolume['industryIdentifiers'];
          Map<String, String> curIdentifiers = new Map<String, String>();
          identifiers.forEach((identifier) {
            (identifier as Map<String, dynamic>).forEach((key, val) {
              curIdentifiers[identifier['type']] = identifier['identifier'];
            });
          });

          List<String> authors = new List<String>.from(curVolume['authors']);
          var curbook = Book(curVolume['title'], authors,
              imageLinks['thumbnail'], curIdentifiers);

          if (curVolume.containsKey('publishedDate')) {
            try {
              curbook.publish_date = DateTime.parse(curVolume['publishedDate']);
            } catch (e) {
              print(e);
            }
          }

          if (curVolume.containsKey('publisher')) {
            curbook.publisher = curVolume['publisher'];
          }
          returnList.add(curbook);
        }
        return returnList;
      }
    } catch (e) {
      print('Exception getting response: ' + e.toString());
      return null;
    }

    return null;
  }

  Widget processSnapshot(AsyncSnapshot<List<Book>> snapshot) {
    if (!snapshot.hasData) {
      return Text("No Result");
    }

    if (snapshot.data.length == 0) {
      return Text("No Search Result");
    }

    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) => ListTile(
        leading: SizedBox(
          child: Image.network(snapshot.data[index].imageUrl),
          width: 30.0,
        ),
        title: Text(snapshot.data[index].title),
        subtitle: Text(snapshot.data[index].authors.join(',')),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookPage(snapshot.data[index])),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: _googleResults,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('none');
          case ConnectionState.active:
            return Text('Active');
          case ConnectionState.waiting:
            return Text('Waiting');
          //return processSnapshot(snapshot);
          case ConnectionState.done:
            return processSnapshot(snapshot);
          default:
            return processSnapshot(snapshot);
        }
        //   return Scaffold(
        //       body: Container(
        //     child: processSnapshot(snapshot),
        //   ),
        //   );
      },
    );
  }
}
