import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {

  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TaskCard({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: Checkbox(
          value: task.completed,
          onChanged: (_) => onToggle(),
        ),

        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed
                ? TextDecoration.lineThrough
                : null,
          ),
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
