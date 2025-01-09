import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import './signup_page.dart';
import 'package:appiot1/screens/homepage.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  Future<void> _login() async {
    // Remplacez ceci par votre logique d'authentification Firebase ou autre service
    try {
      final user = await _auth.loginUserWithEmailAndPassword(
          _email.text, _password.text);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Error"),
          content: Text(e.toString()), // Affiche l'erreur Firebase
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
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
            'assets/bgsign.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
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
                        color: Color.fromARGB(255, 235, 205, 107),
                        width: 2.0,
                      ),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Color.fromARGB(255, 254, 255, 255),
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Register Now",
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



/*import 'package:flutter/material.dart';
import './homepage.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});
  
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
                  padding:const EdgeInsets.only(top:60.0),
                child:const Text(
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
                  padding:const EdgeInsets.only(top:0.0),
                child:const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontFamily:
                        'Fredoka', // Utilisez le nom de famille défini dans pubspec.yaml
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),),
                 const SizedBox(height: 120),
                
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
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
                      color: Color.fromARGB(255, 235, 205, 107), // Couleur de la bordure
                         width: 2.0,          // Épaisseur de la bordure
                        ),
                       ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text('Submit',style: TextStyle(
                      color: Color.fromARGB(255, 254, 255, 255),
                      fontWeight: FontWeight.w700,
                      fontSize: 22
                    )),
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
                    "Don't have an account? Register Now",
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
}*/
