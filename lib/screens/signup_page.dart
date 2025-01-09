import 'dart:developer';
import 'package:flutter/material.dart';
import './signin_page.dart';
import '../auth/auth_service.dart';
import './homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
  }

  Future<void> _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: const Text("User Created With Success"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      // Redirige vers HomePage après une connexion réussie
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image d'arrière-plan
          Image.asset(
            'assets/bgsign.png', // Remplacez par votre image
            fit: BoxFit.cover,
          ),
          // Contenu de la page
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily:
                          'Fredoka', // Utilisez le nom de famille défini dans pubspec.yaml
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: const Text(
                    'Get started, transform your space',
                    style: TextStyle(
                      fontFamily:
                          'Fredoka', // Utilisez le nom de famille défini dans pubspec.yaml
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 235, 205, 107),
                    minimumSize: const Size(double.maxFinite, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(
                        color: Color.fromARGB(
                            255, 235, 205, 107), // Couleur de la bordure
                        width: 2.0, // Épaisseur de la bordure
                      ),
                    ),
                  ),
                  onPressed: _signup,
                  child: const Text('Submit',
                      style: TextStyle(
                          color: Color.fromARGB(255, 254, 255, 255),
                          fontWeight: FontWeight.w700,
                          fontSize: 22)),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninPage()),
                    );
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 1, 2),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
