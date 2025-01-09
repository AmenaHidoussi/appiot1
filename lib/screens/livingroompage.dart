import 'package:appiot1/screens/AirconditionerController.dart';
import 'package:appiot1/screens/notificationspage.dart';
import 'package:flutter/material.dart';
import './lightcontrollingpage.dart';
import './homepage.dart';

class LivingRoomPage extends StatelessWidget {
  const LivingRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Color.fromARGB(255, 241, 226, 173), // Couleur de fond de la barre
        selectedItemColor: Color.fromARGB(
            255, 239, 175, 55), // Couleur des icônes et labels sélectionnés
        unselectedItemColor:
            Colors.grey, // Couleur des icônes non sélectionnées
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 234, 234),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: const Text(
                'Your Living Room',
                style: TextStyle(
                  fontSize: 26,
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
                      Image.asset('assets/high-temperature.png',
                          width: 60, height: 60),
                      const Text(
                        'Temperature',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        '26°C',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/humidity.png', width: 55, height: 55),
                      const Text(
                        'Humidity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        '60%',
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
                          'Light',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          '60%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    // Add Image on the right
                    Image.asset('assets/ceiling-lamp.png',
                        width: 150, height: 100),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
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
                  icon: Icons.ac_unit,
                  label: 'AC',
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