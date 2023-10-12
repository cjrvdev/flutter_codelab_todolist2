import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todolist app',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Todolist app')),
      body: Column(children: [
        Text('Estas son tus tareas pendientes'),
        Progress(),
      ]),
    );
  }
}

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Progreso de las tareas'),
        LinearProgressIndicator(
          value: 0,
        ),
        TaskList()
      ],
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TaskItem(label: 'Comer'),
        TaskItem(label: 'Beber'),
        TaskItem(label: 'New World'),
        TaskItem(label: 'La droga'),
        TaskItem(label: 'Meterme con Judith')
      ],
    );
  }
}

class TaskItem extends StatefulWidget {
  final String label;

  TaskItem({super.key, required this.label});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool? _selected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: _selected,
            onChanged: (newValue) => setState(() => _selected = newValue)),
        Text(widget.label)
      ],
    );
  }
}
