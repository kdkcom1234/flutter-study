import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage> {
  final nameController = TextEditingController();
  int? _radioValue = 0;
  bool? flyExist = false;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    _radioChange(int? value) {}

    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('양서류'),
                  Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('파충류'),
                  Radio(
                      value: 2,
                      groupValue: _radioValue,
                      onChanged: _radioChange),
                  Text('포유류'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("날 수 있나요?"),
                  Checkbox(
                      value: flyExist,
                      onChanged: (bool? check) {
                        setState(() {
                          flyExist = check;
                        });
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/cow.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = "repo/images/cow.png";
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/pig.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = "repo/images/pig.png";
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/bee.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = "repo/images/bee.png";
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/cat.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = "repo/images/cat.png";
                    },
                  ),
                ],
              ),
              ElevatedButton(onPressed: () {}, child: Text('동물 추가하기'))
            ],
          ),
        ),
      ),
    );
  }
}
