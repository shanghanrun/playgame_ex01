import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('가위 바위 보 게임')),
        body: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isFirst = true;
  String userInput = 'rock';
  String cpuInput = '?';
  String result = '무승부';
  final types = ['rock', 'scissors', 'paper'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isFirst
            ? Expanded(
                child: Center(
                  child: initialCpu(),
                ),
              )
            : Expanded(
                child: Center(
                child: doneCpu(),
              )),
        Expanded(
          child: Center(
            child: Container(
                child: Text(
              isFirst ? '아래에서 선택하세요.' : result,
              style: const TextStyle(fontSize: 40, color: Colors.red),
            )),
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              children: [
                Expanded(child: makeContainer('rock')),
                Expanded(child: makeContainer('scissors')),
                Expanded(child: makeContainer('paper')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container doneCpu() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 10, color: Colors.green),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Image.asset('images/$cpuInput.png'),
    );
  }

  Container initialCpu() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(width: 10, color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: const Center(
          child: Text(
        '?',
        style: TextStyle(fontSize: 40, color: Colors.green),
      )),
    );
  }

  Container makeContainer(String type) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
              width: 10,
              color:
                  (!isFirst && userInput == type) ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
            onTap: () {
              setState(() {
                isFirst = false;
                userInput = type;
                cpuInput = types[Random().nextInt(3)];
                result = getResult();
              });
            },
            child: Image.asset('images/$type.png')));
  }

  String getResult() {
    if (userInput == 'rock') {
      if (cpuInput == 'rock') {
        return '무승부';
      } else if (cpuInput == 'scissors') {
        return '유저 승';
      } else if (cpuInput == 'paper') {
        return '컴퓨터 승';
      }
    } else if (userInput == 'scissors') {
      if (cpuInput == 'rock') {
        return '컴퓨터 승';
      } else if (cpuInput == 'scissors') {
        return '무승부';
      } else if (cpuInput == 'paper') {
        return '유저 승';
      }
    } else {
      if (cpuInput == 'rock') {
        return '유저 승';
      } else if (cpuInput == 'scissors') {
        return '컴퓨터 승';
      } else if (cpuInput == 'paper') {
        return '무승부';
      }
    }
    return '무승부';
  }
}
