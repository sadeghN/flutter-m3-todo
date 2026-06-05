import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sadegh/features/models/task.dart';
import 'package:sadegh/features/pages/home_screen.dart';
import 'package:sadegh/features/settings/settings_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasksBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color seedColor = Colors.green;

Brightness brightness = Brightness.light;

void changeBrightness(Brightness newBrightness) {
  setState(() {
    brightness = newBrightness;
  });
}
  void changeColor(Color color) {
    setState(() {
      seedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter M3 Todo',
     theme: ThemeData(
  useMaterial3: true,
  brightness: brightness,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
  ),
),

      routes: {
        "/settings": (context) => const SettingsPage(),
      },
      home: const HomePage(),
    );
  }
}
