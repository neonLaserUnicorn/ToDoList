import 'package:hive/hive.dart';

part "task.g.dart";

@HiveType(typeId: 1)
class Task {
  Task(this.title, this.description);
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  bool status = false;
}
