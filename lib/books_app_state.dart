

import 'package:flutter/cupertino.dart';
import 'package:nested_navigator_2/book.dart';

class BooksAppState extends ChangeNotifier {
  int _selectedIndex;

  Book _selectedBook;

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  BooksAppState() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int idx) {
    _selectedIndex = idx;

    if(_selectedIndex == 1){
      // remove this if you want to keep selected book
      // when navigating between 'settings' and 'home'
      selectedBook = null;
    }

    notifyListeners();
  }
  Book get selectedBook => _selectedBook;

  set selectedBook(Book book){
    _selectedBook = book;

    notifyListeners();
  }

  int getSelectedBookId() {
    if(!books.contains(_selectedBook)) {return 0;}
    return books.indexOf(_selectedBook);
  }

  void setSelectedBookById(int id) {
    if(id < 0 || id > books.length - 1){
      return;
    }
    _selectedBook = books[id];
    notifyListeners();
  }
}