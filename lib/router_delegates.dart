import 'package:flutter/material.dart';
import 'package:nested_navigator_2/app_shell.dart';
import 'package:nested_navigator_2/book.dart';
import 'package:nested_navigator_2/book_detail_screen.dart';
import 'package:nested_navigator_2/books_app_state.dart';
import 'package:nested_navigator_2/books_list_screen.dart';
import 'package:nested_navigator_2/fade_animation_page.dart';

import 'package:nested_navigator_2/routes.dart';
import 'package:nested_navigator_2/settings_screen.dart';

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  BooksAppState appState = BooksAppState();

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  BookRoutePath get currentConfiguration {
    if (appState.selectedIndex == 1) {
      return BooksSettingsPath();
    } else {
      if (appState.selectedBook is! Book) {
        return BooksListPath();
      } else {
        return BookDetailsPath(appState.getSelectedBookId());
      }
    }
  }

  bool _handleOnPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }

    // update the list
    if (appState.selectedBook is Book) {
      appState.selectedBook = null;
    }

    notifyListeners();

    return true;
  }

  /// Called when new route pushed to application
  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    if (path is BooksListPath) {
      appState.selectedIndex = 0;
      appState.selectedBook = null;
    } else if (path is BooksSettingsPath) {
      appState.selectedIndex = 1;
    } else if (path is BookDetailsPath) {
      appState.setSelectedBookById(path.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        /// books list
        MaterialPage(child: AppShell(appState: appState)),
      ],
      onPopPage: _handleOnPopPage,
    );
  }
}

class InnerRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BooksAppState _appState;

  BooksAppState get appState => _appState;

  set appState(BooksAppState value) {
    if (value == _appState) {
      return;
    }

    _appState = value;

    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  void _handleBookTapped(Book book) {
    appState.selectedBook = book;

    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(
              books: appState.books,
              onTapped: _handleBookTapped,
            ),
          ),
          if (appState.selectedBook is Book)
            MaterialPage(
              key: ValueKey(appState.selectedBook),
              child: BookDetailScreen(book: appState.selectedBook),
            )
        ] else
          FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
      ],
      onPopPage: (route, result) {
        appState.selectedBook = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    assert(false);
    return;
  }
}
