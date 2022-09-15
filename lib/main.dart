import 'package:demo_proj/models/task.dart';
import 'package:demo_proj/screens/list_groups.dart';
import 'package:demo_proj/screens/new_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('Tasks');
  runApp(MaterialApp(
    routes: {
      '/list_groups': (context) => const ListGroupsWidget(),
      '/list_groups/new': ((context) => const NewTaskWidget())
    },
    initialRoute: '/list_groups',
  ));
}
