#include <WiFi.h>
#include <PubSubClient.h>
#include <ESP32Servo.h>
#include <DHT.h>

// Configuration WiFi
const char* ssid = "Wokwi-GUEST";
const char* password = "";

// Configuration MQTT
const char* mqtt_server = "broker.hivemq.com";
const char* topic_pub = "smartHome/room1/status";
const char* topic_sub = "smartHome/room1/commands";
WiFiClient espClient;
PubSubClient client(espClient);

// Capteur ultrasonique pour la lampe principale
const int trigPinLamp = 16;
const int echoPinLamp = 4;

// Capteur ultrasonique pour la porte
const int trigPinDoor = 5;
const int echoPinDoor = 18;

// Servo pour la porte
Servo servoDoor;
const int doorPin = 12;

// Lampes (LEDs)
const int lampMainPin = 14;   // Lampe principale
const int lampTempPin = 27;   // Lampe liée à la température

// Capteur de température et d'humidité
#define DHTPIN 15
#define DHTTYPE DHT22
DHT dht(DHTPIN, DHTTYPE);

// Chauffage et Climatiseur
const int heaterPin = 25;
const int acPin = 26;

// Variables pour la température
float targetTemperature = 22.0;

// Seuils
const int lampThreshold = 50;
const int openThreshold = 30;
const int closeThreshold = 70;
float tempLampThreshold = 25.0; // Température pour contrôler la lampe liée à la température

void setup() {
  Serial.begin(115200);

  // Initialisation des capteurs/actionneurs
  pinMode(trigPinLamp, OUTPUT);
  pinMode(echoPinLamp, INPUT);
  pinMode(trigPinDoor, OUTPUT);
  pinMode(echoPinDoor, INPUT);
  pinMode(lampMainPin, OUTPUT);
  pinMode(lampTempPin, OUTPUT);
  pinMode(heaterPin, OUTPUT);
  pinMode(acPin, OUTPUT);
  servoDoor.attach(doorPin);
  servoDoor.write(90);  // Porte fermée par défaut
  digitalWrite(lampMainPin, LOW);
  digitalWrite(lampTempPin, LOW);
  dht.begin();

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

  // Lecture des capteurs
  long distanceLamp = measureDistance(trigPinLamp, echoPinLamp);
  long distanceDoor = measureDistance(trigPinDoor, echoPinDoor);
  float temperature = dht.readTemperature();
  float humidity = dht.readHumidity();

  // Contrôle de la lampe principale
  if (distanceLamp > 0 && distanceLamp < lampThreshold) {
    digitalWrite(lampMainPin, HIGH);
    Serial.println("Lampe principale allumée.");
  } else {
    digitalWrite(lampMainPin, LOW);
    Serial.println("Lampe principale éteinte.");
  }

  // Contrôle de la porte avec le servomoteur
  if (distanceDoor > 0 && distanceDoor < openThreshold) {
    servoDoor.write(0);  // Ouvrir la porte
    Serial.println("Porte ouverte.");
  } else if (distanceDoor > closeThreshold) {
    servoDoor.write(90);  // Fermer la porte
    Serial.println("Porte fermée.");
  }

  // Contrôle du chauffage, climatiseur et lampe liée à la température
  if (!isnan(temperature)) {
    if (temperature < targetTemperature - 1) {
      digitalWrite(heaterPin, HIGH);  // Active le chauffage
      digitalWrite(acPin, LOW);
      Serial.println("Chauffage activé.");
    } else if (temperature > targetTemperature + 1) {
      digitalWrite(heaterPin, LOW);
      digitalWrite(acPin, HIGH);  // Active le climatiseur
      Serial.println("Climatiseur activé.");
    } else {
      digitalWrite(heaterPin, LOW);
      digitalWrite(acPin, LOW);
      Serial.println("Chauffage et climatiseur désactivés.");
    }

    // Contrôle de la lampe liée à la température
    if (temperature > tempLampThreshold) {
      digitalWrite(lampTempPin, HIGH);
      Serial.println("Lampe liée à la température allumée.");
    } else {
      digitalWrite(lampTempPin, LOW);
      Serial.println("Lampe liée à la température éteinte.");
    }
  } else {
    Serial.println("Erreur de lecture du capteur de température !");
  }

  // Publier les données des capteurs
  String status = "Distance lampe: " + String(distanceLamp) + " cm, " +
                  "Distance porte: " + String(distanceDoor) + " cm, " +
                  "Temp: " + String(temperature) + "C, " +
                  "Humidity: " + String(humidity) + "%";
  client.publish(topic_pub, status.c_str());
  Serial.println(status);

  delay(2000);
}

long measureDistance(int trigPin, int echoPin) {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duration = pulseIn(echoPin, HIGH);
  long distance = duration * 0.034 / 2;
  return distance;
}

void connectWiFi() {
  Serial.print("Connexion au WiFi");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connecté !");
}

void connectMQTT() {
  while (!client.connected()) {
    Serial.print("Connexion au serveur MQTT...");
    if (client.connect("ESP32_Room1")) {
      Serial.println("Connecté !");
      client.subscribe(topic_sub);
    } else {
      Serial.print("Échec, rc=");
      Serial.print(client.state());
      delay(5000);
    }
  }
}

void callback(char* topic, byte* payload, unsigned int length) {
  String command = "";
  for (int i = 0; i < length; i++) {
    command += (char)payload[i];
  }
  Serial.print("Commande reçue : ");
  Serial.println(command);

  if (command.startsWith("SET_TEMP")) {
    targetTemperature = command.substring(9).toFloat();
    String response = "Température cible réglée à " + String(targetTemperature) + "C";
    client.publish(topic_pub, response.c_str());
    Serial.println(response);
  }
}
