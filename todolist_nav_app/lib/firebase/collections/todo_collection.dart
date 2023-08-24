import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth.dart';

class TodoContentCollection {
  final String id;
  final String memo;

  TodoContentCollection(this.id, this.memo);
}

getTodoContentRef() =>
    FirebaseFirestore.instance.collection('todos/${getUid()}/contents');

Future<Iterable<TodoContentCollection>> getTodoContents() async {
  final contents = await FirebaseFirestore.instance
      .collection('todos/${getUid()}/contents')
      .get();

  log(contents.docs.length.toString());
  return contents.docs.map((e) => TodoContentCollection(e.id, e["memo"]));
}

Future<String> createTodoContent(String memo) async {
  final contentsRef =
      FirebaseFirestore.instance.collection('todos/${getUid()}/contents');

  DocumentReference<Map<String, dynamic>> doc;
  try {
    doc = await contentsRef.add({"memo": memo});
    return doc.id;
  } catch (e) {
    log(e.toString());
  }
  return "";
}

removeTodoContent(String id) async {}
