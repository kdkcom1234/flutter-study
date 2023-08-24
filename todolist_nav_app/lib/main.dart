import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist_nav_app/screens/todo_detail.dart';
import 'package:todolist_nav_app/screens/todo_form.dart';
import 'package:todolist_nav_app/screens/todo_list.dart';
import 'package:todolist_nav_app/screens/todo_login.dart';

import 'firebase/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();

  runApp(const MyApp());
}

// 파이어베이스앱 초기화
initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log(FirebaseAuth.instance.currentUser.toString());
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
      initialRoute: getUid() == "" ? "/login" : "/",
      routes: {
        '/': (context) => const TodoList(),
        '/login': (context) => const TodoLogin(),
        "/form": (context) => const TodoForm(),
        "/detail": (context) => const TodoDetail()
      },
    );
  }
}
