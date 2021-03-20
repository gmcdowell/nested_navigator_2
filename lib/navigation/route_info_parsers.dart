import 'package:flutter/material.dart';
import 'package:nested_navigator_2/navigation/routes.dart';

class RoutePathInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    RoutePath? routePath;

    // handle '/'
    if (uri.pathSegments.isEmpty) {
      routePath = BooksListPath();
    }

    // handle '/settings'
    else if (uri.pathSegments.first == SettingsPath.path) {
      routePath = SettingsPath();
    }

    // handle '/book/*'
    else if (uri.pathSegments.first == BookDetailsPath.path) {
      if (uri.pathSegments.length == 2) {
        var remaining = uri.pathSegments.last;
        var id = int.tryParse(remaining);

        if (id is int) {
          routePath = BookDetailsPath(id);
        }
      }
    }

    // handle unknown routes
    return routePath ?? UnknownPath();
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath path) {
    // if (path is BooksListPath) {
    //   return RouteInformation(location: '/404');
    // }

    if (path is BooksListPath) {
      return RouteInformation(location: BooksListPath.path);
    } else if (path is BookDetailsPath) {
      return RouteInformation(location: '/${BookDetailsPath.path}/${path.id}');
    } else if (path is SettingsPath) {
      return RouteInformation(location: '/${SettingsPath.path}');
    }

    /// server exception ??
    return RouteInformation(location: '/${UnknownPath.path}');
  }
}
