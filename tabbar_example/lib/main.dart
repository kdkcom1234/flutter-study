import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tabbar_example/firstPage.dart';
import 'package:tabbar_example/secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    controller?.addListener(() {
      if (!controller!.indexIsChanging) {
        if (kDebugMode) {
          print("이전 인덱스: ${controller?.previousIndex}");
          print("현재 인덱스: ${controller?.index}");
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("TabBar Example"),
      ),
      body: TabBarView(
        controller: controller,
        children: const [FirstPage(), SecondPage()],
      ),
      bottomNavigationBar: TabBar(
        tabs: const [
          Tab(
            icon: Icon(
              Icons.looks_one,
              color: Colors.blue,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.looks_two,
              color: Colors.blue,
            ),
          )
        ],
        controller: controller,
      ),
    );
  }

  // 탭컨트롤러는 애니메이션을 사용하므로 dispose를 해줘야함
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
