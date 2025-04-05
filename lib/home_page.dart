import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/counter_page.dart';
import 'package:final_project/area_calculator.dart';
import 'package:final_project/volume_calculator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String? _name;

  Future<void> getData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _db.collection('users').doc(user.uid).get();
      setState(() {
        _name = doc.data()?['name'] ?? "User";
      });
    }
  }

  @override
  void initState(){
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
        
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0), // di sisi kiri dan kanan ada jarak 24px
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_name == null ? "Welcome..." : "Welcome $_name", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const CounterPage()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline),
                      SizedBox(width: 8),
                      Text("Counter", style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const AreaCalculator()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.square_foot),
                      SizedBox(width: 8),
                      Text("Area Calculator", style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const VolumeCalculator()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.view_in_ar),
                      SizedBox(width: 8),
                      Text("Volume Calculator", style: TextStyle(fontSize: 16))
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
