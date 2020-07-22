
import 'dart:ui';

class Book {
  String title;
  String subtitle;
  List<String> authors;
  String publisher;
  DateTime publish_date;
  Map<String, String> industry_identifiers;
  String imageUrl;
  int totalPage;

  bool checkIdentifier(Map<String,String> other_identifiers) {
    for (var curkey in this.industry_identifiers.keys) {
      if (other_identifiers.keys.contains(curkey) && other_identifiers[curkey] == this.industry_identifiers[curkey]) {
        return true;
      }
    }

    return false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book &&
          runtimeType == other.runtimeType &&
          checkIdentifier(other.industry_identifiers);

  @override
  int get hashCode => industry_identifiers.hashCode;

  Book(this.title, this.authors, this.imageUrl, this.industry_identifiers);
}

class UserBook {
  int id;
  Book book;
  String location;
  int totalpage;
  int readpage; 
  DateTime created_at;
  DateTime modified_at;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBook &&
          runtimeType == other.runtimeType &&
          book == other.book;

  @override
  int get hashCode => book.hashCode;

  UserBook(this.book, this.location, this.totalpage, this.readpage, this.created_at, this.modified_at);
}