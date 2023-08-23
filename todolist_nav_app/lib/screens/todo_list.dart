import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/auth.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  List<String> todoList = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    todoList.clear();
    todoList.add("당근 사오기");
    todoList.add("약 사오기");
    todoList.add("청소하기");
    todoList.add("부모님께 전화하기");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text('할 일 목록')),
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Card(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      todoList[index],
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  onTap: () async {
                    final result = await Navigator.of(context).pushNamed(
                        "/detail",
                        arguments: {"data": todoList[index], "index": index});

                    setState(() {
                      todoList.removeAt(result as int);
                    });
                  },
                ),
              ),
              itemCount: todoList.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      signOut().then((value) => {
                            Navigator.of(context).pushReplacementNamed("/login")
                          });
                    },
                    child: const Text("Log out")),
                Text(FirebaseAuth.instance.currentUser!.email as String)
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed("/form");
          setState(() {
            todoList.add(result as String);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
