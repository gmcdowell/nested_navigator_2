import 'package:flutter/material.dart';
import 'package:nested_navigator_2/route_info_parsers.dart';
import 'package:nested_navigator_2/router_delegates.dart';

void main() {
  runApp(NestedRouterDemoApp());
}

class NestedRouterDemoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NestedRouterDemoAppState();
}

class _NestedRouterDemoAppState extends State<NestedRouterDemoApp> {
  BookRouterDelegate _routerDelegate = BookRouterDelegate();
  BookRouteInformationParser _routeInformationParser =
      BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nested Router Demo App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
