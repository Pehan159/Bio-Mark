import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Register a new user
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }

  // Login existing user
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  // Logout user
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error during password reset: $e');
    }
  }

  // Check if a user is currently logged in
  User? get currentUser {
    return _firebaseAuth.currentUser;
  }
}
