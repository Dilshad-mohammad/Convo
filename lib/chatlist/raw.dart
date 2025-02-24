import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;
  void Increment(){
    setState(() {
      counter++;
      print('$counter');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Increment();
      },
      child: Icon(Icons.add)),
      body: Center(
        child: Text('$counter', style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
