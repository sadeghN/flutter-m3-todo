import 'package:flutter/material.dart';
import 'package:sadegh/features/models/task.dart';
import 'package:sadegh/features/widgets/task_card.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Task> tasks = [
    Task(title: "Learn Flutter"),
    Task(title: "Learn Material 3"),
  ];

void showAddTaskSheet() {

  TextEditingController controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true, // ویژگی Material 3
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
                    setState(() {
                      tasks.add(Task(title: controller.text));
                    });
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
    setState(() {
      tasks[index].completed = !tasks[index].completed;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
floatingActionButton: FloatingActionButton(
  onPressed: showAddTaskSheet,
  child: const Icon(Icons.add),
),


      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {

          return TaskCard(
            task: tasks[index],
            onDelete: () => deleteTask(index),
            onToggle: () => toggleTask(index),
          );

        },
      ),
    );
  }
}
