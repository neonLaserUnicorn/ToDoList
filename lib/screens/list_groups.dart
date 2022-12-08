import 'package:demo_proj/models/list_groups_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';

class ListGroupsWidget extends StatelessWidget {
  const ListGroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My tasks')),
      body: ListGroupModelProvider(
          model: ListGroupModel(), child: const _GroupsWidget()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/list_groups/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupsWidget extends StatelessWidget {
  const _GroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final groupCount =
        ListGroupModelProvider.watch(context)?.model.tasks.length ?? 0;
    print(groupCount);
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return _ListElementWidget(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 3,
        );
      },
      itemCount: groupCount,
    );
  }
}

class _ListElementWidget extends StatelessWidget {
  final index;
  const _ListElementWidget(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          ListGroupModelProvider.read(context)!.model.tasks[index].title ?? ''),
      subtitle: Text(ListGroupModelProvider.read(context)!
              .model
              .tasks[index]
              .description ??
          ''),
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
