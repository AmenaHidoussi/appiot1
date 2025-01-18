#include <WiFi.h>
#include <PubSubClient.h>
#include <ESP32Servo.h>  // Bibliothèque standard Servo.h

// Configuration WiFi
const char* ssid = "Wokwi-GUEST";
const char* password = "";

// Configuration MQTT
const char* mqtt_server = "broker.hivemq.com";
const char* topic_gas = "smartHome/kitchen/gasLevel"; // Topic pour la lecture du niveau de gaz
const char* topic_distance = "smartHome/kitchen/distance"; // Topic pour la lecture de la distance
const char* topic_alert = "smartHome/kitchen/alert"; // Topic pour envoyer l'alerte de fuite de gaz
const char* topic_lamp_status = "smartHome/kitchen/lampStatus"; // Topic pour l'état de la lampe
const char* topic_sub = "smartHome/kitchen/commands"; // Topic pour recevoir des commandes
WiFiClient espClient;
PubSubClient client(espClient);

// Capteur de gaz simulé (potentiomètre)
const int gasSensorPin = 34; // GPIO pour simuler le capteur de gaz
int gasValue = 0;            // Valeur lue du "capteur de gaz"

// Capteur ultrasonique pour la LED
const int trigPin = 16; // GPIO pour TRIG
const int echoPin = 4; // GPIO pour ECHO

// LED et actionneurs
const int ledPin = 14;  // GPIO pour la lampe (LED)
Servo servoWindow;     // Servo pour la fenêtre
const int windowPin = 13;  // GPIO pour le servo de la fenêtre

// Variables
const int gasThreshold = 400;    // Seuil pour détecter une fuite de gaz
const int distanceThreshold = 50; // Distance pour allumer/éteindre la lampe

void setup() {
  Serial.begin(115200);

  // Initialisation des capteurs et actionneurs
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(gasSensorPin, INPUT);
  servoWindow.attach(windowPin);
  servoWindow.write(90); // Fenêtre fermée par défaut

  // Connexion WiFi
  connectWiFi();

  // Configuration MQTT
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
  connectMQTT();
}

void loop() {
  if (!client.connected()) {
    connectMQTT();
  }
  client.loop();

  // Lecture du "capteur de gaz" simulé
  gasValue = analogRead(gasSensorPin);

  // Mesurer la distance avec le capteur ultrasonique
  long distance = measureDistance();

  // Publier les données des capteurs sur des topics séparés
  String gasStatus = "Niveau de gaz: " + String(gasValue);
  client.publish(topic_gas, gasStatus.c_str());
  Serial.println(gasStatus);

  String distanceStatus = "Distance: " + String(distance) + " cm";
  client.publish(topic_distance, distanceStatus.c_str());
  Serial.println(distanceStatus);

  // Détection de fuite de gaz et contrôle de la fenêtre
  if (gasValue > gasThreshold) {
    servoWindow.write(0); // Ouvre la fenêtre
    client.publish(topic_alert, "Fuite de gaz détectée, fenêtre ouverte!");
    Serial.println("Fuite de gaz détectée, fenêtre ouverte");
  } else if (gasValue == 0) {
    servoWindow.write(90); // Ferme la fenêtre
    client.publish(topic_alert, "Pas de fuite de gaz détectée, fenêtre fermée");
    Serial.println("Pas de fuite de gaz détectée, fenêtre fermée");
  } else {
    servoWindow.write(0); // Ferme la fenêtre
  }

  // Contrôle de la lampe avec le capteur ultrasonique
  if (distance > 0 && distance < distanceThreshold) {
    digitalWrite(ledPin, HIGH); // Allume la lampe
    client.publish(topic_lamp_status, "Lampe allumée");
    Serial.println("Lampe allumée (distance < seuil)");
  } else {
    digitalWrite(ledPin, LOW); // Éteint la lampe
    client.publish(topic_lamp_status, "Lampe éteinte");
    Serial.println("Lampe éteinte (distance > seuil)");
  }

  delay(2000); // Délai avant la prochaine lecture
}

// Fonction pour mesurer la distance avec le capteur ultrasonique
long measureDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duration = pulseIn(echoPin, HIGH); // Temps en microsecondes
  long distance = duration * 0.034 / 2;   // Convertir en cm
  return distance;
}

// Fonction pour connecter au WiFi
void connectWiFi() {
  Serial.print("Connexion au WiFi");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connecté !");
}

// Fonction pour connecter au serveur MQTT
void connectMQTT() {
  while (!client.connected()) {
    Serial.print("Connexion au serveur MQTT...");
    if (client.connect("ESP32_Kitchen")) {
      Serial.println("Connecté !");
      client.subscribe(topic_sub); // S'abonne aux commandes MQTT
    } else {
      Serial.print("Échec, rc=");
      Serial.print(client.state());
      delay(5000);
    }
  }
}

// Fonction pour traiter les commandes MQTT
void callback(char* topic, byte* payload, unsigned int length) {
  String command = "";
  for (int i = 0; i < length; i++) {
    command += (char)payload[i];
  }
  Serial.print("Commande reçue : ");
  Serial.println(command);

  if (command == "TURN_ON_LAMP") {
    digitalWrite(ledPin, HIGH); // Allume la lampe
    client.publish(topic_lamp_status, "Lampe allumée");
  } else if (command == "TURN_OFF_LAMP") {
    digitalWrite(ledPin, LOW); // Éteint la lampe
    client.publish(topic_lamp_status, "Lampe éteinte");
  } else if (command == "OPEN_WINDOW") {
    servoWindow.write(90); // Ouvre la fenêtre
  } else if (command == "CLOSE_WINDOW") {
    servoWindow.write(0); // Ferme la fenêtre
  }
}
