import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/auth.dart';
import '../firebase/collections/todo_collection.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  List<TodoContentCollection> todoList = List.empty(growable: true);

  getTodos() async {
    final memos = await getTodoContents();
    setState(() {
      todoList.clear();
      todoList.addAll(memos);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (getUid() != "") {
      setState(() {
        getTodos();
      });
    }
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
                      todoList[index].memo,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  onTap: () async {
                    final result = await Navigator.of(context)
                        .pushNamed("/detail", arguments: {
                      "memo": todoList[index].memo,
                      "id": todoList[index].id
                    });

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
                Text(FirebaseAuth.instance.currentUser == null
                    ? ""
                    : FirebaseAuth.instance.currentUser?.email as String)
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed("/form")
              as Map<String, dynamic>;
          setState(() {
            todoList.add(TodoContentCollection(result["id"], result["memo"]));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
