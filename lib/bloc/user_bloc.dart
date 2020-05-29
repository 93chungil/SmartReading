import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:smart_reading/models/book_info.dart';
import 'package:smart_reading/models/group.dart';

class UserBloc extends ChangeNotifier {
  static int _fixedSize = 10; 
  FixedSizeQueue<Book> _recentBooks = new FixedSizeQueue<Book>(_fixedSize);
  FixedSizeQueue<Group> _recentGroups = new FixedSizeQueue<Group>(_fixedSize);
  FixedSizeQueue<String> _recentSearches = new FixedSizeQueue<String>(_fixedSize);


  void addRecentBook(Book book) {
    _recentBooks.add(book);
    notifyListeners();
  }

  List<Book> getRecentBooks() {
    return _recentBooks.getReverseList();
  }

  void addRecentGroup(Group group) {
    _recentGroups.add(group);
    notifyListeners();
  }

  List<Book> getRecentBooks() {
    return _recentBooks.getReverseList();
  }
}





class FixedSizeQueue<T> {
  Queue<T> _queue;
  int _length;

  FixedSizeQueue(this._length) {
    _queue = new Queue<T>();
  }

  void add(T item) {
    _queue.add(item);

    while (_queue.length > _length) {
      _queue.removeFirst();
    }
  }

  List<T> getReverseList() {
    return _queue.toList().reversed.toList();
  }
}