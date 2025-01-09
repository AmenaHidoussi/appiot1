import 'package:appiot1/screens/notificationspage.dart';
import 'package:flutter/material.dart';
import './homepage.dart';

class LightControllingPage extends StatefulWidget {
  const LightControllingPage({super.key});

  @override
  _LightControllingPageState createState() => _LightControllingPageState();
}

class _LightControllingPageState extends State<LightControllingPage> {
  bool isSwitched = true; // Valeur initiale du Switch
  double sliderValue = 60; // Valeur initiale du Slider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 241, 226, 173), // Couleur de fond de la barre
        selectedItemColor: Color.fromARGB(255, 239, 175, 55), // Couleur des icônes et labels sélectionnés
        unselectedItemColor: Colors.grey, // Couleur des icônes non sélectionnées
        onTap: (index) {
          // Navigation vers les pages correspondantes
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  NotificationsPage()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Light",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card with Image
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/lampes.jpg', // Assurez-vous que l'image est présente dans votre dossier assets
                      width: 180,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20), // Espace entre la carte et la colonne des contrôles
                // Controls Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Power",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      // Switch qui peut être activé/désactivé
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value; // Modifie l'état du Switch
                          });
                        },
                        activeColor: Color.fromARGB(255, 239, 175, 55), // Jaune moutarde pour l'état activé
                        inactiveTrackColor: const Color.fromARGB(255, 234, 203, 168), // Gris pour l'état désactivé
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${sliderValue.toStringAsFixed(0)}% Brightness", // Affiche la valeur du Slider
                        style: TextStyle(fontSize: 18),
                      ),
                      // Slider pour ajuster la luminosité
                      Slider(
                        value: sliderValue,
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value; // Modifie la valeur du Slider
                          });
                        },
                        activeColor: Color.fromARGB(255, 239, 175, 55), // Jaune moutarde pour la couleur du Slider
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            // Placeholder for ProgramCard
            ProgramCard(), // Veillez à ajouter votre ProgramCard ici
          ],
        ),
      ),
    );
  }
}

class ProgramCard extends StatelessWidget {
  const ProgramCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Prend toute la largeur disponible
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Program",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 15),
              Text(
                "Use today: 0.6 kWh",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                "Use this month: 6 kWh",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                "Total working hours: 120",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
