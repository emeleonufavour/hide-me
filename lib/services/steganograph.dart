import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:gal/gal.dart';
import 'package:hide_me/services/exceptions.dart';
import 'package:hide_me/services/decryption.dart';
import 'package:hide_me/services/encryption.dart';
import 'package:image/image.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

import '../helpers/file_helper.dart';
import '../helpers/img_helper.dart';

class Steganograph {
  static const String textDataKey = "hidden-message";

  static Future<File?> encodeMessage(
      File image, String message, String password) async {
    try {
      final pngImage = await ImageHelper.convertToPng(image);
      final Size size = ImageSizeGetter.getSize(FileInput(image));

      String encryptedMessage =
          await EncryptionService.getEncryptedMessage(message, password);

      Image imageWithMessage = Image.fromBytes(
        size.width,
        size.height,
        pngImage!.getBytes(),
        textData: {
          textDataKey: encryptedMessage,
        },
      );

      final List<int> imageBytes = encodePng(imageWithMessage);

      String saveAs = "hide_me_${FileHelper.generateRandomString(5)}";
      String? outputPath = FileHelper.generateOutputPath(
          inputFilePath: image.path, outputPath: saveAs);
      HideMeLogger.logMessage(message: "Output path: ${outputPath!}");
      final File finalFile = File(outputPath!);

      await finalFile.writeAsBytes(imageBytes);
      await Gal.putImage(finalFile.path);
      // await Gal.putImageBytes(Uint8List.fromList(imageBytes));
      return finalFile;
    } catch (e) {
      throw HideMeLogger.logWithException(message: message, e: e);
    }
  }

  static Future<String?> decodeMessage(
      {required File image, required String password}) async {
    try {
      final decodedImage = decodePng(await image.readAsBytes());

      String? hiddenMessage = decodedImage?.textData?[textDataKey];

      if (hiddenMessage != null && hiddenMessage.isNotEmpty) {
        return await DecryptionService.getDecryptedMessage(
            hiddenMessage, password);
      }
      return hiddenMessage;
    } catch (e) {
      throw Exception("Unable to decode message from picture");
    }
  }
}
