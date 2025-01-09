import 'package:appiot1/screens/AirconditionerController.dart';
import 'package:appiot1/screens/Notificationspage.dart';
import 'package:flutter/material.dart';
import './lightcontrollingpage.dart';
import './homepage.dart';

class KitchenPage extends StatelessWidget {
  const KitchenPage({super.key});

  void _showGasPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 190, 190), // Rouge foncé proche du blanc rosé
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Coins arrondis
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Ajuste la taille au contenu
            children: [
              Icon(
                Icons.warning,
                color: const Color.fromARGB(255, 212, 31, 18),
                size: 48.0,
              ),
              const SizedBox(height: 10),
              const Text(
                'Gas Alert!!!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 15, 15, 15), // Texte en blanc pour contraste
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Gas has been detected in the kitchen!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 15, 15, 15), // Texte en blanc pour contraste
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color.fromARGB(255, 13, 13, 13), // Bouton texte en blanc
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          MaterialPageRoute(builder: (context) => NotificationsPage()),
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
      // Utilisation d'un Container pour l'arrière-plan
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/kitchenbg.png'), // Remplacez par le chemin de votre image
            fit: BoxFit.cover, // Pour que l'image couvre toute la zone
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 100.0, bottom: 20.0),
                child: const Text(
                  'Your Kitchen',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEFB03B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Temperature and Humidity section
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 249, 205, 124),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showGasPopup(context);
                          },
                          child: Icon(Icons.local_fire_department, color: const Color.fromARGB(255, 2, 2, 2)),
                        ),
                        Text(
                          'Gas',
                          style: TextStyle(color: const Color.fromARGB(255, 2, 2, 2), fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.lightbulb, color: const Color.fromARGB(255, 2, 2, 2)),
                        const Text(
                          'Light 60%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16), // Add some space between the sections
              // Add a Card for Lighting
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Lighting Icon and Text
                      Column(
                        children: [
                          const Text(
                            'Window',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Text(
                            'if there is a gaz!!!',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const Text(
                            'the window will be opened automatically',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      // Add Image on the right
                      Image.asset('assets/window2.png', width: 50, height: 50),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80),
              // Devices title and add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Connected Devices',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Devices cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DeviceCard(
                    icon: Icons.lightbulb,
                    label: 'Lights',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LightControllingPage()),
                      );
                    },
                  ),
                  DeviceCard(
                    icon: Icons.wifi,
                    label: 'Wifi',
                  ),
                  DeviceCard(
                    icon: Icons.local_fire_department,
                    label: 'Gaz',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AirConditionControl()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DeviceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  
  const DeviceCard({super.key, 
    required this.icon,
    required this.label,
     this.onTap, // Marqué comme optionnel
  });

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Gérer les clics
      child: Container(
        width: 80,
        height: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 175, 55),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}