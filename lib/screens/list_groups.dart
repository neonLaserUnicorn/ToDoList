import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';

class ListGroupsWidget extends StatelessWidget {
  const ListGroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My tasks')),
      body: const _GroupsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/list_groups/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupsWidget extends StatefulWidget {
  const _GroupsWidget({super.key});

  @override
  State<_GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<_GroupsWidget> {
  late int count;
  late List<Task> elements;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>('Tasks');
    count = box.values.length;
    elements = box.values.toList();
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return _ListElementWidget(
          title: elements[index].title,
          desc: elements[index].description,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 3,
        );
      },
      itemCount: count,
    );
  }
}

class _ListElementWidget extends StatelessWidget {
  final String? title;
  final String? desc;

  const _ListElementWidget({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title!),
      subtitle: Text(desc!),
      contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      leading: const _CheckerWidget(),
      trailing: const Icon(Icons.chevron_right),
      horizontalTitleGap: 8,
      onTap: () {
        print('PRESS');
      },
    );
  }
}

class _CheckerWidget extends StatefulWidget {
  const _CheckerWidget({super.key});

  @override
  State<_CheckerWidget> createState() => __CheckerWidgetState();
}

class __CheckerWidgetState extends State<_CheckerWidget> {
  bool isTap = false;
  @override
  Widget build(BuildContext context) {
    late Icon icon;

    if (isTap) {
      icon = const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      );
    } else {
      icon = const Icon(
        Icons.check_circle_outline,
        color: Colors.grey,
      );
    }
    return GestureDetector(
      child: icon,
      onTap: () {
        isTap = !isTap;
        setState(() {});
      },
    );
  }
}
