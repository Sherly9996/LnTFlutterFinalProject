import 'package:final_project/home_page.dart';
import 'package:flutter/material.dart';

class VolumeCalculator extends StatefulWidget {
  const VolumeCalculator({super.key});

  @override
  State<VolumeCalculator> createState() => _VolumeCalculatorState();
}

class _VolumeCalculatorState extends State<VolumeCalculator> {
  final TextEditingController _num1 = TextEditingController();
  final TextEditingController _num2 = TextEditingController();
  final TextEditingController _num3 = TextEditingController();
  String? selectedShape; // null artinya belum pilih
  double _result = 0;

  void _calculate(){
    double a = double.tryParse(_num1.text)?? 0;
    double b = double.tryParse(_num2.text)?? 0;
    double c = double.tryParse(_num3.text)?? 0;

    setState(() {
      if (selectedShape == 'balok') {
        _result = a * b * c; //panjang, lebar, tinggi
      } else if (selectedShape == 'piramid') {
        _result = 1/3 * a * b * c; //panjang alas, lebar alas, tinggi piramid
      } else if (selectedShape == 'tabung') {
        _result = 3.14 * a * a * b; //a = jari-jari, b = tinggi tabung
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volume Calculator"),
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
      body: Padding (
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Balok"),
                  onPressed: () {
                    setState(() {
                      selectedShape = "balok";
                    });
                  }
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  child: const Text("Piramid"),
                  onPressed: () {
                    setState(() {
                      selectedShape = "piramid";
                    });
                  }
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  child: const Text("Tabung"),
                  onPressed: () {
                    setState(() {
                      selectedShape = "tabung";
                    });
                  }
                ),
              ]
            ),
            const SizedBox(height: 20),
            if (selectedShape == "balok")...[
              TextField(
                controller: _num1,
                decoration: const InputDecoration(
                  labelText: "Panjang",
                  border: OutlineInputBorder()
                )
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _num2,
                decoration: const InputDecoration(
                  labelText: "Lebar",
                  border: OutlineInputBorder()
                )
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _num3,
                decoration: const InputDecoration(
                  labelText: "Tinggi",
                  border: OutlineInputBorder()
                )
              ),
            ] else if (selectedShape == "piramid") ...[
              TextField(
                controller: _num1,
                decoration: const InputDecoration(
                  labelText: "Panjang Alas",
                  border: OutlineInputBorder()
                )
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _num2,
                decoration: const InputDecoration(
                  labelText: "Lebar Alas",
                  border: OutlineInputBorder()
                )
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _num3,
                decoration: const InputDecoration(
                  labelText: "Tinggi Piramid",
                  border: OutlineInputBorder()
                )
              )
            ] else if (selectedShape == "tabung") ...[
              TextField(
                controller: _num1,
                decoration: const InputDecoration(
                  labelText: "Jari-jari",
                  border: OutlineInputBorder()
                )
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _num2,
                decoration: const InputDecoration(
                  labelText: "Tinggi Tabung",
                  border: OutlineInputBorder()
                )
              )
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate, 
              child: const Text("Hitung Volume")
            ),
            const SizedBox(height: 20),
            Text("Hasil: $_result", style: const TextStyle(fontSize: 20))
          ],
        )  
      ),
    );
  }
}