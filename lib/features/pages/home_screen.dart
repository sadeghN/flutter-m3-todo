import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sadegh/features/models/task.dart';
import 'package:sadegh/features/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Box<Task> taskBox = Hive.box<Task>('tasksBox');

  void showAddTaskSheet() {
    TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "New Task",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Task title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      final task = Task(title: controller.text);
                      taskBox.add(task);
                      setState(() {});
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Add Task"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void toggleTask(int index) {
    final task = taskBox.getAt(index);
    if (task != null) {
      task.completed = !task.completed;
      task.save();
      setState(() {});
    }
  }

  void deleteTask(int index) {
    final deletedTask = taskBox.getAt(index);

    taskBox.deleteAt(index);
    setState(() {});

    if (deletedTask == null) return;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${deletedTask.title}" Deleted'), 
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            taskBox.add(deletedTask);
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        centerTitle: true,
        actions: [
  IconButton(
    icon: const Icon(Icons.settings),
    onPressed: () {
      Navigator.pushNamed(context, "/settings");
    },
  )
],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskSheet,
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (context, Box<Task> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text(" Task list is empty! "));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index)!;

              return Dismissible(
                key: Key(task.key.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.delete_sweep,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                onDismissed: (_) => deleteTask(index),
                child: TaskCard(
                  task: task,
                  onDelete: () => deleteTask(index),
                  onToggle: () => toggleTask(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
