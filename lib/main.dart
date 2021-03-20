import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:nested_navigator_2/navigation/navigation_state.dart';
import 'package:nested_navigator_2/services/books_data_service.dart';

import 'package:nested_navigator_2/navigation/route_info_parsers.dart';
import 'package:nested_navigator_2/navigation/router_delegates.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        /// books data service
        Provider<BooksDataService>(
          create: (context) => BooksDataService(),
        ),

        /// navigation state
        ChangeNotifierProvider<NavigationState>(
          create: (context) => NavigationState(
            booksDataService:
                Provider.of<BooksDataService>(context, listen: false),
          ),
        ),
      ],
      child: NestedRouterDemoApp(),
    ),
  );
}

class NestedRouterDemoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NestedRouterDemoAppState();
}

class _NestedRouterDemoAppState extends State<NestedRouterDemoApp> {
  late MainRouterDelegate _routerDelegate;

  late RoutePathInformationParser _routeInformationParser;

  @override
  void initState() {
    super.initState();

    var navState = Provider.of<NavigationState>(context, listen: false);

    _routerDelegate = MainRouterDelegate(navState: navState);

    _routeInformationParser = RoutePathInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nested Router Demo App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
