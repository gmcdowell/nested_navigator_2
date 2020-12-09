import 'package:flutter/material.dart';
import 'package:nested_navigator_2/navigation/navigation_state.dart';
import 'package:nested_navigator_2/navigation/router_delegates.dart';

class AppShell extends StatefulWidget {
  final NavigationState navState;

  AppShell({@required this.navState});

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.navState);
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);

    _routerDelegate.navState = widget.navState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.navState;

    _backButtonDispatcher.takePriority();

    return Scaffold(
      // appBar: AppBar(),
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Books'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: appState.selectedBottomTabIndex,
        onTap: (newIndex) {
          appState.selectedBottomTabIndex = newIndex;
        },
      ),
    );
  }
}
