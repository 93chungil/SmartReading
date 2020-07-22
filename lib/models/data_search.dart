import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_reading/models/book.dart';
import 'package:smart_reading/screens/search_result_page.dart';

class DataSearch extends SearchDelegate<String> {
  final books = ['Death', 'Originals', 'Thinking Fast and Slow', '관점을 디자인하다'];
  final recentbooks = ['Death', '관점을 디자인하다'];

  List<Book> _googleResults;
  Future<List<Book>> searchGoogleBooks(String qry) async {
    List<Book> returnList = new List<Book>();
    var url = "https://www.googleapis.com/books/v1/volumes?q=" + qry;
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
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
        var curbook = Book(curVolume['title'], authors, imageLinks['thumbnail'],
            curIdentifiers);

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

        if (curVolume.containsKey('pageCount')) {
          curbook.totalPage = curVolume['pageCount'];
        }
        returnList.add(curbook);
      }
    }

    return returnList;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Add Book Search, User/Group Search
    //searchGoogleBooks(query).then((val) => _googleResults = val);
    
    return SearchResultPage(query);
    
    // return FutureBuilder<List<Book>>(
    //   future: searchGoogleBooks(query),
    //   builder: (context, snapshot) {
    //     switch(snapshot.connectionState) {
    //       case ConnectionState.none:
    //         return Text('none');
    //       case ConnectionState.active:
    //       case ConnectionState.waiting:
    //         return Text('Active and maybe waiting');
    //       case ConnectionState.done:
    //         return Text('done');
    //       default:
    //         return Text('done');
    //     }
    //     return Scaffold(
    //         body: Container(
    //       child: processSnapshot(snapshot),
    //     ));
    //   },
    // );

    // Center(
    //   child: Container(
    //     height: 100.0,
    //     width: 100.0,
    //     child: Card(
    //       color: Colors.red,
    //       shape: StadiumBorder(),
    //       child: Center(
    //         child: Text(query),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget processSnapshot(AsyncSnapshot<List<Book>> snapshot) {
    if (!snapshot.hasData) {
      return Text("No Result");
    }

    if (snapshot.data.length == 0) {
      return Text("No Search Result");
    }

    return Expanded(
      child: ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) => ListTile(
          leading: Image.asset(snapshot.data[index].imageUrl),
          title: Text(snapshot.data[index].title),
          subtitle: Text(snapshot.data[index].authors.join(',')),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentbooks
        : books.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.book),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
    );
  }
}
