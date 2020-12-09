import 'package:flutter/material.dart';
import 'package:nested_navigator_2/routes.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    BookRoutePath routePath;

    // handle '/'
    if (uri.pathSegments.isEmpty) {
      routePath = BooksListPath();
    }

    // handle '/settings'
    else if (uri.pathSegments.first == 'settings') {
      routePath = BooksSettingsPath();
    }

    // handle '/book/*'
    else if (uri.pathSegments.first == 'book') {
      if (uri.pathSegments.length == 2) {
        var remaining = uri.pathSegments.last;
        var id = int.tryParse(remaining);

        if (id is int) {
          routePath = BookDetailsPath(id);
        }
      }
    }

    // handle unknown routes
    return routePath ?? BookUnknownPath();
  }

  @override
  RouteInformation restoreRouteInformation(BookRoutePath path) {
    // if (path is BooksListPath) {
    //   return RouteInformation(location: '/404');
    // }

    if (path is BooksListPath) {
      return RouteInformation(location: '/');
    }

    else if (path is BookDetailsPath) {
      return RouteInformation(location: '/book/${path.id}');
    }

    else if (path is BooksSettingsPath){
      return RouteInformation(location: '/settings');
    }

    /// server exception ??
    return RouteInformation(location: '/404');
  }
}
