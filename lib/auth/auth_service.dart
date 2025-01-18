import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
      return null;
    }
  }

 Future<User?> loginUserWithEmailAndPassword(
  String email, String password) async {
  try {
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    if (cred.user != null) {
      // Affichage des détails de l'utilisateur après une connexion réussie
      print("User authenticated: ${cred.user!.uid}");
      print("Email: ${cred.user!.email}");
      print("User display name: ${cred.user!.displayName ?? 'No display name'}");
      // Vérification du type d'objets supplémentaires que vous récupérez
     
      return cred.user;
    } else {
      print("User is null after sign-in");
      return null;
    }
  } catch (e) {
    // Affichage de l'erreur
    print("Erreur lors de la connexion : $e");

    // Si l'exception contient des informations supplémentaires
    if (e is FirebaseAuthException) {
      print("Firebase error code: ${e.code}");
      print("Firebase error message: ${e.message}");
    }

    return null;
  }
}

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}
