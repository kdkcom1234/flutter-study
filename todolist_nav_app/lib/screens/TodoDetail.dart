import 'package:flutter/material.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("할 일 상세"),
      ),
      body: Center(
        child: Text(
          args["data"] as String,
          style: const TextStyle(fontSize: 40),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(args["index"] as int);
        },
        child: const Icon(Icons.delete_outline),
      ),
    );
  }
}
