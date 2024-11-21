import 'package:biomark/src/utils/hashing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_service.dart';
import 'auth_service.dart';

class AccountRecoveryService {
  final FirebaseService _firebaseService = FirebaseService();
  final AuthService _authService = AuthService();

  // Verify user input against stored hashed values in Firebase
  Future<bool> verifyAccount({
    required String fullName,
    required String dob,
    required String childhoodPetsName,
    required String childhoodBestFriendsName,
  }) async {
    try {
      // Hash the inputs
      String hashedFullName = HashingUtils.hashData(fullName);
      String hashedDob = HashingUtils.hashData(dob);
      String hashedChildhoodPetsName = HashingUtils.hashData(childhoodPetsName);
      String hashedChildhoodBestFriendsName =
          HashingUtils.hashData(childhoodBestFriendsName);

      // Fetch the stored hashed data from Firebase

      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('volunteers')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        var storedData = userDoc.data() as Map<String, dynamic>;

        // Compare hashed values
        if (storedData['fullName'] == hashedFullName &&
            storedData['dateOfBirth'] == hashedDob &&
            storedData['childhoodPetsName'] == hashedChildhoodPetsName &&
            storedData['childhoodBestFriendsName'] ==
                hashedChildhoodBestFriendsName) {
          return true;
        }
      }

      return false;
    } catch (e) {
      print('Error verifying account: $e');
      return false;
    }
  }
}

//   // Verify recovery questions and reset the password
//   Future<bool> verifyRecoveryQuestions(String uid, Map<String, String> recoveryAnswers) async {
//     // Fetch the volunteer data from Firebase
//     Map<String, dynamic>? volunteerData = await _firebaseService.getVolunteerData(uid);
//
//     if (volunteerData == null) {
//       return false;
//     }
//
//     // Check if recovery answers match the stored answers
//     if (volunteerData['securityAnswer1'] == recoveryAnswers['securityAnswer1'] &&
//         volunteerData['securityAnswer2'] == recoveryAnswers['securityAnswer2']) {
//       return true;
//     }
//
//     return false;
//   }
//
//   // Reset the user's password after verification
//   Future<void> resetPassword(String email, String newPassword) async {
//     await _authService.resetPassword(email);
//     // Optionally, update the password in Firebase Authentication
//     // FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
//   }
// }
