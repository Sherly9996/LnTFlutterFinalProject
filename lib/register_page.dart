import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

Future<void> register() async {
  String id = _idController.text.trim();
  String email = _emailController.text.trim();
  String name = _nameController.text.trim();
  String password = _passController.text.trim();
  String confirmPassword = _confirmPassController.text.trim();

  if (id.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("ID Bimbel wajib diisi")));
    return;
  }
  if (email.isEmpty || !email.contains('@') || !email.endsWith('.com')) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email harus mengandung '@' dan '.com'")));
    return;
  }
  if (name.isEmpty || name.length < 5) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nama minimal 5 huruf")));
    return;
  }
  if (password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password wajib diisi")));
    return;
  }
  if (confirmPassword != password) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Konfirmasi password tidak cocok")));
    return;
  }

  try {
    // Membuat akun Firebase Auth
    UserCredential credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Simpan data tambahan ke Firestore
    await _db.collection('users').doc(credentials.user?.uid).set({
      'uid': credentials.user?.uid,
      'id_bimbel': id,
      'email': email,
      'name': name
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registrasi berhasil! Silakan login.")));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage()
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
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: "ID Bimbel",
                  border: OutlineInputBorder()
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder()
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _confirmPassController,
                decoration: const InputDecoration(
                  labelText: "Konfirmasi Password",
                  border: OutlineInputBorder()
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Register"),
              onPressed: () {
                register();
              },
            ),
            TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage()
                  )
                );
              },
              child: const Text("Sudah punya akun? Login"),
            )
          ],
        ),
      )
    );
  }
}



         

