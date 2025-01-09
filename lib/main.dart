import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import pour Firebase
import 'package:appiot1/screens/signup_page.dart'; // Votre page d'inscription

void main() async {
  // Initialisation des widgets et de Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Lancement de l'application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Supprime le bandeau de debug
      home: const HomeScreen(), // Utilisation d'une route pour la page principale
      routes: {
        '/signup': (context) => const SignUpPage(), // Définition d'une route pour la page d'inscription
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image d'arrière-plan
          Image.asset(
            'assets/pageacceuil3.png', // Chemin vers votre image
            fit: BoxFit.cover,
          ),
          // Contenu au-dessus de l'image
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Texte principal
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: const [
                    Text(
                      "Your Space Connected",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Your life, easier and safer.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Bouton en bas
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup'); // Utilise la route définie
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

















/*import 'package:flutter/material.dart';
import 'package:appiot1/screens/signup_page.dart';


void main() {
  runApp(const MaterialApp(
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Image d'arrière-plan
            Image.asset(
              'assets/pageacceuil3.png', // Remplacez par votre image
              fit: BoxFit.cover,
            ),
            // Contenu au-dessus de l'image
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Texte principal
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Text(
                        "Your Space Connected",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                         
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Your life, easier and safer.",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Bouton en bas
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home UI',
      home: Scaffold(
        body: Stack(
          children: [
            // Image d'arrière-plan
            Positioned.fill(
             
              child: Image.asset(
                'assets/pageacceuil3.png',  // Remplacez par votre image
                width: double.infinity, 
                fit: BoxFit.fill,
              ),
            ),
            // Contenu de la page
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titre
               Padding(
                     padding: const EdgeInsets.only(top: 14),
                  child: Text(
                  'Your Space Connected',
                  style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily:"Fredoka One",
                 color: Colors.white,
                       ),
                 ),
                     ),
                // Sous-titre
                const Text(
                  'Your life, easier and safer.',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(), // Espacement pour pousser le bouton vers le bas
                // Bouton avec bordure, texte et flèche
                Padding(
                  
                  padding: const EdgeInsets.all(0.8),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.white, // Couleur de la bordure
                        width: 4, // Largeur de la bordure
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal:20), // Espacement autour du texte
                    ),
                    onPressed: () {
                      // Utiliser Builder pour obtenir un contexte propre
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: Row(
                       
                      children: [
                        const Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white, // Couleur du texte
                            fontSize: 22,
                            
                          ),
                        ),
                        const SizedBox(width: 20), // Espacement entre le texte et la flèche
                        const Icon(
                          Icons.arrow_forward, // Icône flèche
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/








     
     
