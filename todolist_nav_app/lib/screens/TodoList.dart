import 'package:flutter/material.dart';

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
                final result = await Navigator.of(context).pushNamed("/detail",
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
