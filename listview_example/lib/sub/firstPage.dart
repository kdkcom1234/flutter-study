import 'package:flutter/material.dart';

import '../animalItem.dart';

class FirstPage extends StatelessWidget {
  final List<Animal>? list;
  const FirstPage({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, position) {
            return GestureDetector(
              child: Card(
                  child: Row(
                children: [
                  Image.asset(
                    list![position].imagePath!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  Text(list![position].animalName!)
                ],
              )),
              onTap: () {
                AlertDialog dialog = AlertDialog(
                  content: Text('이 동물은 ${list![position].kind}',
                      style: TextStyle(fontSize: 30.0)),
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
              },
            );
          },
          // 아이템 카운트값을 꼭 넣어줘야 에러발생 안 함
          itemCount: list!.length,
        ),
      ),
    );
  }
}
