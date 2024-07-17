import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:hex/hex.dart';

import 'encryption.dart';

class DecryptionService {
  static Future<List<int>> decryptData(
      String encryptedData, String password) async {
    List<int> pBytes = EncryptionService.getPasswordBytes(password, 32);
    List<String> splittedData = encryptedData.split('%');
    if (splittedData.length != 3) {
      throw Exception('Invalid cipher text size');
    }
    String nonce = splittedData[0];
    String cipherText = splittedData[1];
    String mac = splittedData[2];

    List<int> decodedHexNonce = HEX.decode(nonce);
    List<int> decodedHexText = HEX.decode(cipherText);
    List<int> decodedHexMac = HEX.decode(mac);

    AesGcm algorithm = AesGcm.with256bits();
    SecretBox secretBox = SecretBox(decodedHexText,
        nonce: decodedHexNonce, mac: Mac(decodedHexMac));
    SecretKey secretKey = await algorithm.newSecretKeyFromBytes(pBytes);
    List<int> decryptedData =
        await algorithm.decrypt(secretBox, secretKey: secretKey);
    return decryptedData;
  }

  static Future<String> getDecryptedMessage(
      String encryptedData, String password) async {
    final List<int> decrypt = await decryptData(encryptedData, password);
    final String decodedMessage = utf8.decode(decrypt);

    return decodedMessage;
  }
}
