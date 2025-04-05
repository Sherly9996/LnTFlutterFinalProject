import 'package:final_project/register_page.dart';
import 'package:final_project/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future <void> login() async {
    String email = _emailController.text.trim();
    String password = _passController.text.trim();
    if (email.isEmpty || !email.contains('@') || !email.endsWith('.com')) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email harus mengandung '@' dan '.com'")));
      return;
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password wajib diisi")));
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Kalau login berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
        content: Text("Login berhasil!")
        )
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
         builder: (context) => const HomePage()
        )
      ); 
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!)
        )
      );
    }   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder()
                ),
                controller: _emailController
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder()
                ),
                obscureText: true,
                controller: _passController
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: (){
                login();
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const RegisterPage())
                 );
               },
              child: const Text("Belum punya akun? Register")
            )
          ],
        ),
      ),
    );
  }
}