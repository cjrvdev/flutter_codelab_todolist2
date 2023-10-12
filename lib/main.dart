import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: MainApp()));

final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier(tasks: [
    Task(id: 1, label: 'Salir'),
    Task(id: 2, label: 'Beber'),
    Task(id: 3, label: 'El mismo rollo de siempre'),
  ]);
});

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
        SizedBox(
          height: 10,
        ),
        Progress(),
        SizedBox(
          height: 10,
        ),
        TaskList()
      ]),
    );
  }
}

class Progress extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);

    var numCompletedTasks = tasks.where((task) {
      return task.completed == true;
    }).length;

    return Column(
      children: [
        Text('Progreso de las tareas'),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: LinearProgressIndicator(
            value: numCompletedTasks / tasks.length,
          ),
        )
      ],
    );
  }
}

class TaskList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(tasksProvider);

    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: tasks
              .map(
                (task) => TaskItem(task: task),
              )
              .toList(),
        ));
  }
}

class TaskItem extends ConsumerWidget {
  final Task task;

  TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Checkbox(
            value: task.completed,
            onChanged: (newValue) =>
                ref.read(tasksProvider.notifier).toggle(task.id)),
        Text(task.label)
      ],
    );
  }
}

@immutable
class Task {
  final int id;
  final String label;
  final bool completed;

  Task({required this.id, required this.label, this.completed = false});

  Task copyWith({int? id, String? label, bool? completed}) {
    return Task(
        id: id ?? this.id,
        label: label ?? this.label,
        completed: completed ?? this.completed);
  }
}

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier({tasks}) : super(tasks);

  void add(Task task) {
    state = [...state, task];
  }

  void toggle(int taskId) {
    state = [
      for (final item in state)
        if (taskId == item.id)
          item.copyWith(completed: !item.completed)
        else
          item
    ];
  }
}
