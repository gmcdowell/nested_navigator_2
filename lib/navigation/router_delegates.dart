import 'package:flutter/material.dart';
import 'package:nested_navigator_2/app_shell.dart';
import 'package:nested_navigator_2/models/book.dart';
import 'package:nested_navigator_2/screens/book_detail_screen.dart';
import 'package:nested_navigator_2/navigation/navigation_state.dart';
import 'package:nested_navigator_2/screens/books_list_screen.dart';
import 'package:nested_navigator_2/navigation/pages/fade_animation_page.dart';

import 'package:nested_navigator_2/navigation/routes.dart';
import 'package:nested_navigator_2/screens/settings_screen.dart';

class MainRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationState navState;

  MainRouterDelegate({
    Key? key,
    required this.navState,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    navState.addListener(notifyListeners);
  }

  RoutePath get currentConfiguration {
    if (navState.selectedBottomTabIndex == 1) {
      return SettingsPath();
    } else {
      if (navState.selectedBook is! Book) {
        return BooksListPath();
      } else {
        return BookDetailsPath(navState.selectedBook!.id);
      }
    }
  }

  bool _handleOnPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }

    // update the list
    if (navState.selectedBook is Book) {
      navState.selectedBook = null;
    }

    notifyListeners();

    return true;
  }

  /// Called when new route pushed to application
  @override
  Future<void> setNewRoutePath(RoutePath path) async {
    if (path is BooksListPath) {
      navState.selectedBottomTabIndex = 0;
      navState.selectedBook = null;
    } else if (path is SettingsPath) {
      navState.selectedBottomTabIndex = 1;
    } else if (path is BookDetailsPath) {
      navState.setSelectedBookById(path.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        /// home (books list)
        MaterialPage(
          child: AppShell(navState),
        ),
      ],
      onPopPage: _handleOnPopPage,
    );
  }
}

class InnerRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigationState _navState;

  NavigationState get navState => _navState;

  set navState(NavigationState value) {
    if (value == _navState) {
      return;
    }

    _navState = value;

    notifyListeners();
  }

  InnerRouterDelegate(this._navState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (navState.selectedBottomTabIndex == 0) ...[
          FadeAnimationPage(
            child: BooksListScreen(),
          ),
          if (navState.selectedBook is Book)
            MaterialPage(
              key: ValueKey(navState.selectedBook),
              child: BookDetailScreen(book: navState.selectedBook),
            )
        ] else
          FadeAnimationPage(
            child: SettingsScreen(),
            key: ValueKey('SettingsPage'),
          ),
      ],
      onPopPage: (route, result) {
        // navState.selectedBook = null;
        navState.setSelectedBookById(0);
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    assert(false);
    return;
  }
}
