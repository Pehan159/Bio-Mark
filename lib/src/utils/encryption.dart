import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionUtils {
  static final key = encrypt.Key.fromLength(32); // 256-bit key
  static final iv = encrypt.IV.fromLength(16); // 128-bit IV

  // Encrypts the given plain text
  static String encryptData(String plainText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  // Decrypts the given encrypted text
  static String decryptData(String encryptedText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
