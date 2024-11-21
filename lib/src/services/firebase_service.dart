import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../config/constants.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save volunteer data to Firebase
  Future<void> saveVolunteerData(
      String uid, Map<String, dynamic> volunteerData) async {
    try {
      await _firestore.collection('volunteers').doc(uid).set(volunteerData);
    } catch (e) {
      print('Error saving volunteer data: $e');
    }
  }

  // Fetch volunteer data from Firebase
  Future<Map<String, dynamic>?> getVolunteerData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('volunteers').doc(uid).get();
      //return snapshot.data() as Map<String, dynamic>?;
      return snapshot.data();
    } catch (e) {
      print('Error fetching volunteer data: $e');
      return null;
    }
  }

  // Update volunteer email in Firebase
  Future<void> updateVolunteerEmail(String uid, String newEmail) async {
    try {
      await _firestore
          .collection('volunteers')
          .doc(uid)
          .update({'email': newEmail});
    } catch (e) {
      print('Error updating email: $e');
    }
  }

  // Delete volunteer profile from Firebase (Unsubscribe functionality)
  Future<void> deleteVolunteerProfile(String uid) async {
    try {
      await _firestore.collection('volunteers').doc(uid).delete();
    } catch (e) {
      print('Error deleting profile: $e');
    }
  }

  // Save profile data (for ProfileSetupScreen)
  Future<void> saveProfileData(Map<String, dynamic> profileData) async {
    try {
      // Assuming you have the user ID from FirebaseAuth
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await _firestore
          .collection(AppConstants.volunteerProfilesCollection)
          .doc(uid)
          .set(profileData);
    } catch (e) {
      print('Error saving profile data: $e');
      throw e;
    }
  }

  // Method to fetch profile data from Firebase Firestore
  Future<Map<String, dynamic>?> fetchProfileData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection(AppConstants.volunteerProfilesCollection)
          .doc(userId)
          .get();

      return snapshot.data();
    } catch (e) {
      print('Error fetching profile data: $e');
      return null; // Handle error appropriately, maybe throw or return null
    }
  }

  // Delete the user's profile from Firebase Firestore
  Future<void> deleteUserProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('volunteers')
          .doc(currentUser.uid)
          .delete();

      // Optionally, delete their authentication record as well
      await currentUser.delete();
    }
  }
}
