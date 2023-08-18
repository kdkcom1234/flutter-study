import 'package:flutter/material.dart';
import 'package:todolist_nav_app/screens/TodoDetail.dart';
import 'package:todolist_nav_app/screens/TodoForm.dart';
import 'package:todolist_nav_app/screens/TodoList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList with Navigation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => const TodoList(),
        "/form": (context) => const TodoForm(),
        "/detail": (context) => const TodoDetail()
      },
    );
  }
}
