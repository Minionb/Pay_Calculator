import 'package:flutter/material.dart';
import 'package:puiyeeng_mapd722_a1_pay_calculator/About.dart';
import 'package:puiyeeng_mapd722_a1_pay_calculator/MainCalculation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  // This widget is the root of the application, displaying Main part and About Part.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pay Calculator'),
          backgroundColor: const Color.fromARGB(250, 250, 250, 225),
          ),
          backgroundColor: const Color.fromARGB(250, 250, 250, 160),
          body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: MainCalculation(),
              ),
              Expanded(
                flex: 1,
                child: About(),
              ),
            ],
          ),
        ),
      )
      )
    );
  }
}

