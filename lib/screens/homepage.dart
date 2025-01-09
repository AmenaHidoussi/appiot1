import 'package:appiot1/screens/kitchenpage.dart';
import 'package:flutter/material.dart';
import './livingroompage.dart';
import './Notificationspage.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              'Welcome home,',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Color(0xFFEFB03B)),
            textAlign: TextAlign.center),
            Expanded(
              child: ListView(
                children: [
                  RoomCard(
                    title: 'Living Room',
                    imagePath: 'assets/Rectangle12.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LivingRoomPage()),
                      );
                    },
                  ), SizedBox(height: 40),
                  RoomCard(
                    title: 'Kitchen',
                    imagePath: 'assets/Rectangle13.png',
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KitchenPage()),
                      );
                    },
                  ),SizedBox(height: 40),
                  RoomCard(
                    title: ' BedRoom',
                    imagePath: 'assets/Rectangle14.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LivingRoomPage()),
                      );
                    },
                  ),SizedBox(height: 40),
                   RoomCard(
                    title: ' BathRoom',
                    imagePath: 'assets/Rectngle16.jpg',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LivingRoomPage()),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const RoomCard({super.key, required this.title, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 18,
              left: 16,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
