import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nested_navigator_2/models/book.dart';
import 'package:nested_navigator_2/services/books_data_service.dart';

class NavigationState extends ChangeNotifier {
  final BooksDataService _booksDataService;

  int _selectedBottomTabIndex;

  StreamSubscription<Book> _selectedBookStreamSub;

  NavigationState({
    Key key,
    @required BooksDataService booksDataService,
  })  : _selectedBottomTabIndex = 0,
        _booksDataService = booksDataService {
    /// listen to currentBook changes
    // _selectedBookStreamSub = _booksDataService.currentBookSub.listen((event) {
    //   notifyListeners();
    // });
  }

  int get selectedBottomTabIndex => _selectedBottomTabIndex;

  set selectedBottomTabIndex(int idx) {
    _selectedBottomTabIndex = idx;

    // if (_selectedBottomTabIndex == 1) {
    //   // remove this if you want to keep selected book
    //   // when navigating between 'settings' and 'home'
    //   // selectedBook = null;
    //
    //   _booksDataService.unsetCurrentBook();
    // }

    notifyListeners();
  }

  Book get selectedBook => _booksDataService.currentBookSub.value;

  set selectedBook(Book book) {
    _booksDataService.unsetCurrentBook();
  }

  // used by router delegate for url changes
  void setSelectedBookById(int id) {
    // _booksDataService.setCurrentBookById(id);

    notifyListeners();
  }

  @override
  void dispose() {
    if (_selectedBookStreamSub is StreamSubscription) {
      _selectedBookStreamSub.cancel();
    }

    super.dispose();
  }
}
