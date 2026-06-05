import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sadegh/features/models/task.dart';
import '../../main.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool animationsEnabled = true;

  final colors = [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    final appState = MyApp.of(context);
    final selectedColor = appState.seedColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [

          /// ------------------ Appearance Section ------------------
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Appearance",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          SwitchListTile(
            title: const Text("Dark Mode"),
            secondary: const Icon(Icons.dark_mode),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });

              appState.changeBrightness(
                value ? Brightness.dark : Brightness.light,
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("Theme Color"),
            subtitle: const Text("Select your preferred color"),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              children: colors.map((color) {
                final isSelected = selectedColor == color;

                return GestureDetector(
                  onTap: () {
                    appState.changeColor(color);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Theme updated"),
                        duration: Duration(seconds: 1),
                      ),
                    );

                    setState(() {});
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: color,
                      ),
                      if (isSelected)
                        const Icon(Icons.check,
                            color: Colors.white),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(height: 32),

          /// ------------------ App Section ------------------
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "App",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          SwitchListTile(
            title: const Text("Enable Animations"),
            secondary: const Icon(Icons.animation),
            value: animationsEnabled,
            onChanged: (value) {
              setState(() {
                animationsEnabled = value;
              });
            },
          ),

          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text("Clear All Tasks"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete All Tasks?"),
                  content: const Text(
                      "This action cannot be undone."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Hive.box<Task>('tasksBox').clear();
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("All tasks deleted"),
                          ),
                        );
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );
            },
          ),

          const Divider(height: 32),

          /// ------------------ About Section ------------------
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "About",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About App"),
            subtitle: const Text("Version 1.0.0"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Flutter M3 Todo",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2026 Sadegh",
              );
            },
          ),
        ],
      ),
    );
  }
}
