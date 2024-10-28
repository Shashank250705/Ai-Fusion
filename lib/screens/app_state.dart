import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  final List<String> favoriteTools;
  final Function(String) addTool;
  final Function(String) removeTool;

  AppState({
    Key? key,
    required Widget child,
    required this.favoriteTools,
    required this.addTool,
    required this.removeTool,
  }) : super(key: key, child: child);

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return oldWidget.favoriteTools != favoriteTools;
  }
}
