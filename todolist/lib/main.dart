import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class TodoItem {
  String memo;
  TodoItem(this.memo);
}

class HomeWidgetState extends State<HomeWidget> {
  TextEditingController textController = TextEditingController();
  var inputValue = "";
  var list = List<TodoItem>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Todo list"),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    controller: textController,
                  ),
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      list.add(TodoItem(textController.text));
                      textController.text = "";
                    });
                  },
                  child: const Text("ADD"))
            ],
          ),
          ListView(
            padding: const EdgeInsets.all(30),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: list.reversed
                .map((e) => GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(e.memo),
                      ),
                      onTap: () {
                        setState(() {
                          list.removeAt(list.indexOf(e));
                        });
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
