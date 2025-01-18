# appiot1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

The "kitchen simulation" folder contains the Wokwi simulation code for the ESP32 edge device, including sensor data processing, actuator control, and MQTT communication, to prototype and validate kitchen automation before real-world deployment.

The "smartroom simulation" folder contains the Wokwi simulation code for the ESP32 edge device, including sensor data processing, actuator control, and MQTT communication, to prototype and validate automation for living rooms and bedrooms before real-world deployment.

The "smartroom_gettingdatafromMQTT" folder contains ESP32 code to fetch MQTT data (temperature, humidity, light) and automate control of room conditions (e.g., adjusting lights, HVAC) for living rooms and bedrooms, validated via simulation before real-world use.

The "sketchfromfirebasetomqtt" folder contains code for sending data from Firebase (received via the app) to an MQTT server, enabling communication between the app, Firebase, and IoT devices.

The "sketchfromMQTTtofirebase" folder contains code for receiving data from an MQTT server (e.g., sensor readings like temperature, humidity, or light levels) and sending it to Firebase. This enables real-time data storage and synchronization with the application for monitoring and control.


