import 'package:demo_proj/models/task.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ListGroupModel {
  String? title;
  String? description;

  void saveTask(BuildContext context) {
    final box = Hive.box<Task>('Tasks');
    box.add(Task(title, description));
    Navigator.of(context).pop();
  }
}

class ListGroupModelProvider extends InheritedWidget {
  final ListGroupModel model;

  const ListGroupModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, child: child);

  static ListGroupModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ListGroupModelProvider>()
        ?.widget;
    return widget is ListGroupModelProvider ? widget : null;
  }

  static ListGroupModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListGroupModelProvider>();
  }

  @override
  bool updateShouldNotify(ListGroupModelProvider oldWidget) {
    return oldWidget.model != model;
  }
}
