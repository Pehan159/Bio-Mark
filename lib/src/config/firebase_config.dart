import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseConfig {
  // Method to initialize Firebase in the app
  static Future<void> initializeFirebaseApp() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      print("Firebase initialized successfully");
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }
}
