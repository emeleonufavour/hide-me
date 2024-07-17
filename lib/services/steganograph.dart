import 'dart:io';

import 'package:hide_me/services/exceptions.dart';
import 'package:hide_me/services/decryption.dart';
import 'package:hide_me/services/encryption.dart';
import 'package:image/image.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

import '../helpers/file_helper.dart';
import '../helpers/img_helper.dart';

class Steganograph {
  String textDataKey = "hidden-message";

  Future<File?> encodeMessage(
      File image, String message, String password, String saveAs) async {
    try {
      final pngImage = await ImageHelper.convertToPng(image);
      final Size size = ImageSizeGetter.getSize(FileInput(image));

      String encryptedMessage =
          await EncryptionService.getEncryptedMessage(message, password);

      Image imageWithMessage = Image.fromBytes(
        width: size.width,
        height: size.height,
        bytes: pngImage!.getBytes().buffer,
        textData: {
          textDataKey: encryptedMessage,
        },
      );

      final List<int> imageBytes = encodePng(imageWithMessage);

      final File finalFile = File(FileHelper.generateOutputPath(
          inputFilePath: image.path, outputPath: saveAs)!);

      await finalFile.writeAsBytes(imageBytes);
      return finalFile;
    } catch (e) {
      throw HideMeLogger.logWithException(message: message, e: e);
    }
  }

  Future<String?> decodeMessage(
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
