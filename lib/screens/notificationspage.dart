import 'package:flutter/material.dart';
import './homepage.dart';


class NotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> alertHistory = [
    {
      'icon': Icons.warning,
      'type': 'Gas Leak',
      'date': '2025-01-03 12:45 PM',
      'status': 'Resolved',
    },
    {
      'icon': Icons.water_damage,
      'type': 'Water Overflow',
      'date': '2025-01-02 09:30 AM',
      'status': 'Unresolved',
    },
    {
      'icon': Icons.electrical_services,
      'type': 'Power Surge',
      'date': '2025-01-01 03:20 PM',
      'status': 'Resolved',
    },
     {
      'icon': Icons.thermostat, // Icone pour la température
      'type': 'High Temperature',
      'date': '2025-01-03 02:15 PM',
      'status': 'Unresolved',
    },
     {
      'icon': Icons.open_in_new, // Fenêtre ouverte
      'type': 'Window Open',
      'date': '2025-01-03 01:00 PM',
      'status': 'Unresolved',
    },
    {
      'icon': Icons.door_back_door, // Porte ouverte
      'type': 'Door Open',
      'date': '2025-01-03 12:45 PM',
      'status': 'Resolved',
    },
      {
      'icon': Icons.door_front_door, // Porte fermée
      'type': 'Door Closed',
      'status': 'Resolved',
      'date': '2025-01-03 12:45 PM',
    },
      {
      'icon': Icons.close, // Fenêtre fermée
      'type': 'Window Closed',
      'status': 'Resolved',
      'date': '2025-01-03 11:50 AM',
    },
  ];

  NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Alert History'),
        backgroundColor: const Color.fromARGB(
            255, 252, 163, 163), // Rouge foncé proche du blanc rosé
      ),
      body: ListView.builder(
        itemCount: alertHistory.length,
        itemBuilder: (context, index) {
          final alert = alertHistory[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              leading: Icon(
                alert['icon'],
                color: Colors.red,
                size: 32,
              ),
              title: Text(
                alert['type'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(alert['date']),
              trailing: Text(
                alert['status'],
                style: TextStyle(
                  color:
                      alert['status'] == 'Resolved' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NotificationsPage(),
  ));
}
