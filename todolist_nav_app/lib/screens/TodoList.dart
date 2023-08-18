import 'package:flutter/material.dart';
import 'package:todolist_nav_app/screens/TodoForm.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('Sub Page Main')),
      body: const Center(
        child: Text("첫 번째 페이지"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const TodoForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
