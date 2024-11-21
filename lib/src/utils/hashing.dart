import 'package:crypto/crypto.dart';
import 'dart:convert';

class HashingUtils {
  // Hashes the input data (like a password) using SHA-256
  static String hashData(String inputData) {
    final bytes = utf8.encode(inputData); // Convert to bytes
    final digest = sha256.convert(bytes); // Perform SHA-256 hashing
    return digest.toString(); // Return hashed output as string
  }

  // Compares input data with an existing hash
  static bool verifyHash(String inputData, String storedHash) {
    final hashedInput = hashData(inputData);
    return hashedInput == storedHash;
  }
}
