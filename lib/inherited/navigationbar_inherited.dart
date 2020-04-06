import 'package:flutter/material.dart';

class NavigationBarInherited extends InheritedWidget {
  final int index;

  NavigationBarInherited({@required this.index, @required Widget child})
      : super(child: child);

  static NavigationBarInherited of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(NavigationBarInherited);
  }

  @override
  bool updateShouldNotify(NavigationBarInherited oldWidget) {
    // TODO: implement updateShouldNotify
    return index != oldWidget.index;
  }
}
