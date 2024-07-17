import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:hex/hex.dart';

class EncryptionService {
  static List<int> getPasswordBytes(String password, int maxBytes) {
    final pBytes = utf8.encode(password).toList();
    final passwordLength = pBytes.length;
    if (maxBytes > passwordLength) {
      for (int i = 0; i < (maxBytes - passwordLength); i++) {
        pBytes.add(64326913);
      }
    } else if (passwordLength > maxBytes) {
      pBytes.sublist(0, maxBytes);
    }
    return pBytes;
  }

  static Future<String> encryptData(String password, List<int> data) async {
    List<int> passwordInBytes = getPasswordBytes(password, 32);
    AesGcm algorithm = AesGcm.with256bits();
    List<int> nonce = algorithm.newNonce();
    SecretKey secretKey =
        await algorithm.newSecretKeyFromBytes(passwordInBytes);
    SecretBox secretBox =
        await algorithm.encrypt(data, secretKey: secretKey, nonce: nonce);
    final cipherText = secretBox.cipherText;
    final List<int> mac = secretBox.mac.bytes;

    final String hexCodedCipher = HEX.encode(cipherText);
    final String hexCodedNonce = HEX.encode(nonce);
    final String hexCodedMac = HEX.encode(mac);

    String encryptedText = '$hexCodedNonce%$hexCodedCipher%$hexCodedMac';
    return encryptedText;
  }

  static Future<String> getEncryptedMessage(
      String message, String password) async {
    List<int> messageToBytes = utf8.encode(message);
    final encryptedData = await encryptData(password, messageToBytes);

    return encryptedData;
  }
}
