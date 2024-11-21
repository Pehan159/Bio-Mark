// import 'package:flutter/material.dart';
// import '../services/firebase_service.dart';
// import '../models/volunteer.dart';
//
// class ProfileProvider with ChangeNotifier {
//   Volunteer? _volunteerProfile;
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   Volunteer? get volunteerProfile => _volunteerProfile;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;
//
//   // Method to load the user's profile data
//   Future<void> loadProfile(String userId) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _volunteerProfile = await FirebaseService().getVolunteerProfile(userId);
//       _errorMessage = '';
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // Method to update the profile (email and password can be changed)
//   Future<void> updateProfile(Volunteer updatedProfile) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       await FirebaseService().updateVolunteerProfile(updatedProfile);
//       _volunteerProfile = updatedProfile;
//       _errorMessage = '';
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
