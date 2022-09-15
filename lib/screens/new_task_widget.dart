import 'package:demo_proj/models/list_groups_model.dart';
import 'package:flutter/material.dart';

class NewTaskWidget extends StatefulWidget {
  const NewTaskWidget({super.key});

  @override
  State<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends State<NewTaskWidget> {
  final _model = ListGroupModel();
  @override
  Widget build(BuildContext context) {
    return ListGroupModelProvider(
        model: _model, child: const NewTaskWidgetBody());
  }
}

class NewTaskWidgetBody extends StatelessWidget {
  const NewTaskWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новое дело')),
      body: const _NewTaskFormWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () =>
            ListGroupModelProvider.read(context)?.model.saveTask(context),
      ),
    );
  }
}

class _NewTaskFormWidget extends StatelessWidget {
  const _NewTaskFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Название задания',
            ),
            onChanged: (value) {
              ListGroupModelProvider.read(context)?.model.title = value;
            },
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Описание',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            ListGroupModelProvider.read(context)?.model.description = value;
          },
        ),
      ],
    );
  }
}
