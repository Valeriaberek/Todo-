import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  final List<Map<String, dynamic>> todos;
  final void Function(int index) onToggle;
  final void Function(int index) onDelete;

  const TasksPage({super.key, required this.todos, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final t = todos[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Checkbox(
                value: t['done'] as bool,
                onChanged: (_) => onToggle(index),
              ),
              title: Text(
                t['title'] as String,
                style: TextStyle(decoration: (t['done'] as bool) ? TextDecoration.lineThrough : null),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
