import 'package:demo_proj/models/task.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewTaskModel {
  String? title;
  String? description;

  void saveTask(BuildContext context) {
    final box = Hive.box<Task>('Tasks');
    if (title != null) {
      box.add(Task(title, description));
    }
    Navigator.of(context).pop();
    // .pushNamedAndRemoveUntil('/list_groups', (route) => false);
  }
}

class ListGroupModel extends ChangeNotifier {
  var _tasks = <Task>[];
  List<Task> get tasks {
    return _tasks.toList();
  }

  ListGroupModel() {
    _setup();
  }

  void getTasksFromBox(Box<Task> box) {
    print('HELL YEAH');
    _tasks = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    final box = await Hive.openBox<Task>("Tasks");
    getTasksFromBox(box);
    box.listenable().addListener(() => getTasksFromBox(box));
  }
}

class NewTaskModelProvider extends InheritedNotifier {
  final NewTaskModel model;

  const NewTaskModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, child: child);

  static NewTaskModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<NewTaskModelProvider>()
        ?.widget;
    return widget is NewTaskModelProvider ? widget : null;
  }

  static NewTaskModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NewTaskModelProvider>();
  }

  @override
  bool updateShouldNotify(NewTaskModelProvider oldWidget) {
    return oldWidget.model != model;
  }
}

class ListGroupModelProvider extends InheritedNotifier {
  final ListGroupModel model;
  const ListGroupModelProvider(
      {super.key, required super.child, required this.model});

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
    return true;
  }
}
