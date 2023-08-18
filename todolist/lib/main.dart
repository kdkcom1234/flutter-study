import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class TodoItem {
  int id;
  String memo;

  // 이름 없는 생성자
  // 이름 있는 생성자 선언시에 필수적으로 선언해야함
  TodoItem(this.id, this.memo);
  // 이름 있는 생성자
  TodoItem.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        memo = json["memo"];
}

class HomeWidgetState extends State<HomeWidget> {
  TextEditingController textController = TextEditingController();
  var inputValue = "";
  var list = List<TodoItem>.empty(growable: true);
  var currentPage = 0;
  var last = false;

  fetchData({int page = 0}) async {
    final res = await http
        .get(Uri.parse("http://10.0.2.2:8080/todo?page=$page&size=10"));

    if (kDebugMode) {
      print(res.statusCode);
      print(res.body);
    }
    // 한글이 깨짐
    // Map<String, dynamic> data = jsonDecode(res.body);
    // utf-8
    Map<String, dynamic> data = jsonDecode(utf8.decode(res.bodyBytes));
    List content = data["content"];

    setState(() {
      list.addAll(content.map((e) => TodoItem.fromJson(e)).toList());
      currentPage = page;
      last = data["last"] as bool;
    });
  }

  Future<bool> removeData(int id) async {
    final res = await http.delete(Uri.parse("http://10.0.2.2:8080/todo/$id"));
    if (kDebugMode) {
      print(res.statusCode);
    }
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> createData(String memo) async {
    final res = await http.post(Uri.parse("http://10.0.2.2:8080/todo"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({"memo": memo}));

    if (kDebugMode) {
      print(res.statusCode);
    }

    if (res.statusCode == 201) {
      Map<String, dynamic> body = jsonDecode(utf8.decode(res.bodyBytes));
      return body["data"]["id"] as int;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // --------- 헤더
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Todo list"),
            )
          ]),
          // --------- 폼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    controller: textController,
                  ),
                ),
              ),
              OutlinedButton(
                  onPressed: () async {
                    int id = await createData(textController.text);
                    if (id > 0) {
                      setState(() {
                        list.insert(0, TodoItem(id, textController.text));
                        textController.text = "";
                      });
                    }
                  },
                  child: const Text("ADD"))
            ],
          ),
          // --------- 리스트
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(30),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1)),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Text(list[index].memo),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () async {
                              bool result = await removeData(list[index].id);
                              if (kDebugMode) {
                                print(result);
                              }

                              if (result) {
                                setState(() {
                                  list.removeAt(index);
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.green,
                            ))
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          // --------- More 버튼
          last
              ? const Row()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          fetchData(page: currentPage + 1);
                        },
                        child: const Text("More"))
                  ],
                )
        ],
      ),
    );
  }
}
