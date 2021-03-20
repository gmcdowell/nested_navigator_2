import 'package:flutter/material.dart';
import 'package:nested_navigator_2/core/abstract_widget_view.dart';
import 'package:nested_navigator_2/navigation/navigation_state.dart';
import 'package:nested_navigator_2/navigation/router_delegates.dart';

class AppShell extends StatefulWidget {
  final NavigationState navState;

  AppShell(this.navState);

  @override
  _AppShellController createState() => _AppShellController();
}

class _AppShellController extends State<AppShell> {
  late InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void initState() {
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
        .backButtonDispatcher!
        .createChildBackButtonDispatcher();

    _backButtonDispatcher!.takePriority();
  }

  @override
  Widget build(BuildContext context) => _AppShellView(this);
}

class _AppShellView extends WidgetView<AppShell, _AppShellController> {
  _AppShellView(_AppShellController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Router(
        routerDelegate: state._routerDelegate,
        backButtonDispatcher: state._backButtonDispatcher,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: widget.navState.selectedBottomTabIndex,
        onTap: (newIndex) {
          widget.navState.selectedBottomTabIndex = newIndex;
        },
      ),
    );
  }
}
