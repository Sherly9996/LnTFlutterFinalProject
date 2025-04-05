import 'package:final_project/home_page.dart';
import 'package:flutter/material.dart';

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({super.key});

  @override
  State<AreaCalculator> createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  final TextEditingController _num1 = TextEditingController();
  final TextEditingController _num2 = TextEditingController();
  String? selectedShape; // null artinya belum pilih
  double _result = 0;

  void _calculate(){
    double a = double.tryParse(_num1.text)?? 0;
    double b = double.tryParse(_num2.text)?? 0;

    setState(() {
      if (selectedShape == 'persegi') {
        _result = a * a;
      } else if (selectedShape == 'segitiga') {
        _result = 0.5 * a * b;
      } else if (selectedShape == 'lingkaran') {
        _result = 3.14 * a * a;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Area Calculator"),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => selectedShape = "persegi");
                  },
                  child: const Text("Persegi")
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() => selectedShape = "segitiga");
                  },
                  child: const Text("Segitiga")
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() => selectedShape = "lingkaran");
                  },
                  child: const Text("Lingkaran")
                ),
              ],
            ),
            const SizedBox(height: 20),
            //... -> memasukkan list ke dalam list (children[])
            if (selectedShape == "persegi") ...[
              TextField(
                controller: _num1, 
                decoration: const InputDecoration(
                  labelText: "Sisi",
                  border: OutlineInputBorder()
                )
              ),
            ] else if (selectedShape == "segitiga") ...[
              TextField(
                controller: _num1, 
                decoration: const InputDecoration(
                  labelText: "Alas",
                  border: OutlineInputBorder()
                )
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _num2, 
                decoration: const InputDecoration(
                  labelText: "Tinggi",
                  border: OutlineInputBorder()
                )
              ),
            ] else if (selectedShape == "lingkaran") ...[
              TextField(
                controller: _num1, 
                decoration: const InputDecoration(
                  labelText: "Jari-jari",
                  border: OutlineInputBorder()
                )
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text("Hitung Luas"),
            ),
            const SizedBox(height: 20),
            Text("Hasil: $_result", style: const TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}
