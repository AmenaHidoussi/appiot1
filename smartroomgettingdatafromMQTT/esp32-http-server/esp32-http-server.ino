#include <WiFi.h>
#include <PubSubClient.h>

// Configuration WiFi
const char* ssid = "Wokwi-GUEST";  // Remplacez par votre SSID WiFi
const char* password = "";         // Laissez vide si aucun mot de passe

// Configuration MQTT
const char* mqtt_server = "broker.hivemq.com";
const char* topic_temperature = "smartHome/room/temperature"; // Topic pour la température
const char* topic_humidity = "smartHome/room/humidite";       // Topic pour l'humidité
WiFiClient espClient;
PubSubClient client(espClient);

// Variables pour stocker les données reçues
float temperature = 0.0;
float humidity = 0.0;

void setup() {
  Serial.begin(115200);

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

  // Afficher les données reçues
  Serial.print("Température: ");
  Serial.print(temperature);
  Serial.print(" °C, Humidité: ");
  Serial.print(humidity);
  Serial.println(" %");

  delay(2000);  // Attendre 2 secondes avant la prochaine lecture
}

void connectWiFi() {
  Serial.print("Connexion au WiFi...");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.print("Connecté au WiFi. IP: ");
  Serial.println(WiFi.localIP());
}

void connectMQTT() {
  while (!client.connected()) {
    Serial.print("Connexion au serveur MQTT...");
    if (client.connect("ESP32Client")) {
      Serial.println("Connecté !");

      // S'abonner aux topics
      client.subscribe(topic_temperature); // S'abonner à la température
      client.subscribe(topic_humidity);    // S'abonner à l'humidité
    } else {
      Serial.print("Échec, rc=");
      Serial.print(client.state());
      Serial.println(" Nouvelle tentative dans 5 secondes...");
      delay(5000);
    }
  }
}

void callback(char* topic, byte* payload, unsigned int length) {
  // Convertir le payload en une chaîne de caractères
  String message = "";
  for (int i = 0; i < length; i++) {
    message += (char)payload[i];
  }

  Serial.print("Message reçu sur le topic [");
  Serial.print(topic);
  Serial.print("]: ");
  Serial.println(message);

  // Mettre à jour les variables en fonction du topic
  if (String(topic) == topic_temperature) {
    temperature = message.toFloat();  // Convertir le payload en float
    Serial.println("Température mise à jour : " + String(temperature) + " °C");
  } else if (String(topic) == topic_humidity) {
    humidity = message.toFloat();  // Convertir le payload en float
    Serial.println("Humidité mise à jour : " + String(humidity) + " %");
  }
}