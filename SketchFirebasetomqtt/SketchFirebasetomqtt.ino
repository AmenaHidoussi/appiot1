#include <Arduino.h>
#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <PubSubClient.h>  // MQTT library

// Provide the token generation process info.
#include "addons/TokenHelper.h"
// Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

// Insert your network credentials
#define WIFI_SSID "globalnet"
#define WIFI_PASSWORD "14652404"

// Insert Firebase project API Key
#define API_KEY "AIzaSyBqtESoti_OySo2gkWGppR-Al3pGzGk8cE"

// Insert RTDB URL
#define DATABASE_URL "https://smarthome-d5d33-default-rtdb.firebaseio.com/"

// MQTT Server Information
const char* mqtt_server = "broker.hivemq.com";
WiFiClient espClient;
PubSubClient client(espClient);

// Define Firebase Data object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

bool signupOK = false;

// Buffer to store incoming MQTT messages
struct MQTTMessage {
  String topic;
  String payload;
};
MQTTMessage mqttMessage;
bool newMessageReceived = false;

// Function to extract integer value from a string
int extractInt(String message, String prefix) {
  int startIndex = message.indexOf(prefix);
  if (startIndex == -1) {
    Serial.println("Prefix not found in message.");
    return -1;  // Return -1 if prefix is not found
  }
  startIndex += prefix.length();
  int endIndex = message.indexOf(" ", startIndex);
  if (endIndex == -1) endIndex = message.length();
  return message.substring(startIndex, endIndex).toInt();
}

// Function to connect to MQTT broker
void connectMQTT() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    
    // Check WiFi connection
    if (WiFi.status() != WL_CONNECTED) {
      Serial.println("WiFi not connected. Reconnecting...");
      WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
      delay(5000);  // Wait for WiFi to reconnect
      continue;
    }

    // Attempt to connect to the MQTT broker with a unique client ID
    if (client.connect("ESP32Client")) {
      Serial.println("connected");

      // Subscribe to the topics
      const char* topics[] = {
        "smartHome/kitchen/gasLevel",
        "smartHome/kitchen/distance",
        "smartHome/kitchen/alert",
        "smartHome/kitchen/lampStatus"
      };
      for (const char* topic : topics) {
        if (client.subscribe(topic)) {
          Serial.print("Subscribed to ");
          Serial.println(topic);
        } else {
          Serial.print("Failed to subscribe to ");
          Serial.println(topic);
        }
      }
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());  // Print the error code if the connection failed
      Serial.println(" Trying again in 2 seconds.");
      delay(2000);  // Retry connection every 2 seconds
    }
  }
}

// Callback function to handle incoming MQTT messages
void mqttCallback(char* topic, byte* payload, unsigned int length) {
  // Store the incoming message in the buffer
  mqttMessage.topic = String(topic);
  mqttMessage.payload = "";
  for (int i = 0; i < length; i++) {
    mqttMessage.payload += (char)payload[i];
  }
  newMessageReceived = true;  // Set the flag to indicate a new message
}

// Function to read data from Firebase and publish to MQTT
void readFromFirebaseAndPublishToMQTT() {
  // Read temperature from Firebase
  if (Firebase.RTDB.getFloat(&fbdo, "/smartHome/room/temperature")) {
    float temperature = fbdo.floatData();
    String payload = String(temperature);
    if (client.publish("smartHome/room/temperature", payload.c_str())) {
      Serial.println("Temperature published to MQTT: " + payload);
    } else {
      Serial.println("Failed to publish temperature to MQTT.");
    }
  } else {
    Serial.println("Failed to read temperature from Firebase.");
    Serial.println("REASON: " + fbdo.errorReason());
  }

  // Read humidity from Firebase
  if (Firebase.RTDB.getFloat(&fbdo, "/smartHome/room/humidite")) {
    float humidity = fbdo.floatData();
    String payload = String(humidity);
    if (client.publish("smartHome/room/humidite", payload.c_str())) {
      Serial.println("Humidity published to MQTT: " + payload);
    } else {
      Serial.println("Failed to publish humidity to MQTT.");
    }
  } else {
    Serial.println("Failed to read humidity from Firebase.");
    Serial.println("REASON: " + fbdo.errorReason());
  }
}

void setup() {
  Serial.begin(115200);

  // Connect to Wi-Fi
  Serial.print("Connecting to Wi-Fi...");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected to Wi-Fi. IP: ");
  Serial.println(WiFi.localIP());

  // Firebase Setup
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  // Sign Up to Firebase
  Serial.print("Signing up to Firebase...");
  if (Firebase.signUp(&config, &auth, "", "")) {
    Serial.println("Firebase SignUp Successful");
    signupOK = true;
  } else {
    Serial.printf("SignUp failed: %s\n", config.signer.signupError.message.c_str());
  }

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  // MQTT Setup
  client.setServer(mqtt_server, 1883);
  client.setCallback(mqttCallback);  // Set the callback function to handle incoming messages

  // Connect to MQTT
  connectMQTT();
}

void loop() {
  // Reconnect to WiFi if disconnected
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("WiFi disconnected. Reconnecting...");
    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    delay(5000);
  }

  // Reconnect to MQTT if disconnected
  if (!client.connected()) {
    connectMQTT();
  }

  // Keep listening for incoming MQTT messages
  client.loop();

  // Process new MQTT messages
  if (newMessageReceived) {
    newMessageReceived = false;  // Reset the flag

    Serial.print("Received message for topic [");
    Serial.print(mqttMessage.topic);
    Serial.print("]: ");
    Serial.println(mqttMessage.payload);

    // Extract and send data to Firebase based on the topic
    if (mqttMessage.topic == "smartHome/kitchen/gasLevel") {
      int gasLevel = extractInt(mqttMessage.payload, "Niveau de gaz: ");
      if (gasLevel != -1 && Firebase.RTDB.setInt(&fbdo, "smartHome/kitchen/gasLevel", gasLevel)) {
        Serial.println("Gas level sent to Firebase.");
      } else {
        Serial.println("Failed to send gas level to Firebase.");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    } else if (mqttMessage.topic == "smartHome/kitchen/distance") {
      int distance = extractInt(mqttMessage.payload, "Distance: ");
      if (distance != -1 && Firebase.RTDB.setInt(&fbdo, "smartHome/kitchen/distance", distance)) {
        Serial.println("Distance sent to Firebase.");
      } else {
        Serial.println("Failed to send distance to Firebase.");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    } else if (mqttMessage.topic == "smartHome/kitchen/alert") {
      if (Firebase.RTDB.setString(&fbdo, "smartHome/kitchen/alert", mqttMessage.payload)) {
        Serial.println("Alert sent to Firebase.");
      } else {
        Serial.println("Failed to send alert to Firebase.");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    } else if (mqttMessage.topic == "smartHome/kitchen/lampStatus") {
      if (Firebase.RTDB.setString(&fbdo, "smartHome/kitchen/lampStatus", mqttMessage.payload)) {
        Serial.println("Lamp status sent to Firebase.");
      } else {
        Serial.println("Failed to send lamp status to Firebase.");
        Serial.println("REASON: " + fbdo.errorReason());
      }
    }
  }

  // Read data from Firebase and publish to MQTT
  readFromFirebaseAndPublishToMQTT();

  // Optional: Add a small delay to reduce CPU usage
  delay(100);
}