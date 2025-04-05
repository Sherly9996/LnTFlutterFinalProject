import 'package:final_project/home_page.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _increment(){
    setState(() {
      _counter++;
    });
  }

  void _decrement(){
    setState(() {
      _counter--;
    });
  }

  void _reset(){
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context)=> const HomePage())  
            );
          },
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _increment, 
                  child: const Text("+", style: TextStyle(fontSize: 20))),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _decrement, 
                  child: const Text("-", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _reset, 
                  child: const Text("Reset", style: TextStyle(fontSize: 16)))
              ]
            )
          ],
        ),
      ),
    );
  }
}