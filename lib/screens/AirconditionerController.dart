import 'package:flutter/material.dart';
import './homepage.dart';

class AirConditionControl extends StatefulWidget {
  const AirConditionControl({super.key});

  @override
  _AirConditionControlState createState() => _AirConditionControlState();
}

class _AirConditionControlState extends State<AirConditionControl> {
  double currentTemperature = 23; // Température initiale

  String getMood() {
    if (currentTemperature < 10) {
      return "Cool";
    } else if (currentTemperature >= 10 && currentTemperature < 27) {
      return "Dry";
    } else if (currentTemperature >= 27 && currentTemperature <= 32) {
      return "Warm";
    } else {
      return "Heat";
    }
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case "Cool":
        return const Color.fromARGB(255, 102, 180, 248);
      case "Dry":
        return const Color.fromARGB(255, 3, 136, 244); // Bleu moins foncé
      case "Warm":
        return Colors.redAccent; // Rouge foncé
      case "Heat":
        return const Color.fromARGB(255, 169, 11, 11); // Beaurdeau
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Color.fromARGB(255, 248, 235, 190), // Couleur de fond de la barre
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
                MaterialPageRoute(builder: (context) => const HomePage()),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/airconditioner.png"), // Chemin de votre image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Air Conditioner Controller",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: 20), // Espacement
            Center(
              child: SizedBox(
                height: 250, // Taille du cercle
                width: 250, // Taille du cercle
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value:
                          (currentTemperature - 5) / (50 - 5), // Plage [5, 50]
                      strokeWidth: 150, // Épaisseur du cercle
                      valueColor: AlwaysStoppedAnimation<Color>(
                          const Color.fromARGB(255, 94, 183, 255)),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    Text(
                      "${currentTemperature.toInt()}°",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 36, 36, 36)),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      if (currentTemperature > 5) currentTemperature--;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      if (currentTemperature < 50) currentTemperature++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action Turn Off
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(205, 255, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new, color: Colors.white),
                      SizedBox(width: 5),
                      Text("Turn Off"),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Action Turn On
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 19, 173, 42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new, color: Colors.white),
                      SizedBox(width: 5),
                      Text("Turn On"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text("Weather",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoodButton(
                    icon: Icons.ac_unit,
                    label: "Cool",
                    isSelected: getMood() == "Cool",
                    color: const Color.fromARGB(255, 89, 200, 255)),
                MoodButton(
                  icon: Icons.water_drop,
                  label: "Dry",
                  isSelected: getMood() == "Dry",
                  color: getMoodColor("Dry"),
                ),
                MoodButton(
                  icon: Icons.wb_sunny,
                  label: "Warm",
                  isSelected: getMood() == "Warm",
                  color: getMoodColor("Warm"),
                ),
                MoodButton(
                  icon: Icons.local_fire_department,
                  label: "Hot",
                  isSelected: getMood() == "Heat",
                  color: getMoodColor("Heat"),
                ),
                
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class MoodButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color color;

  const MoodButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor:
              isSelected ? color : const Color.fromARGB(255, 237, 234, 234),
          child: Icon(icon, color: isSelected ? Colors.white : Colors.black),
        ),
        SizedBox(height: 10),
        Text(label, style: TextStyle(color: isSelected ? color : Colors.black)),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(home: AirConditionControl()));
}
