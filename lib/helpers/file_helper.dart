import 'dart:io';
import 'dart:math';

import 'package:hide_me/services/exceptions.dart';
import 'package:hide_me/helpers/img_helper.dart';

class FileHelper {
  static String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  static String? generatePath(String path) {
    try {
      final fileName = "hide_me_${generateRandomString(5)}.png";

      final splitPath = path.split(Platform.pathSeparator);
      splitPath.removeLast();

      if (splitPath.isEmpty) {
        return fileName;
      }

      return "${splitPath.join("/")}/$fileName";
    } catch (e) {
      HideMeLogger.logWithException(message: "Invalid file: $path", e: e);
    }
  }

  static String? generateOutputPath({
    required String inputFilePath,
    String? outputPath,
  }) {
    try {
      if (ImageHelper.getImageType(outputPath!) == "png") {
        return outputPath;
      }
    } catch (e) {
      HideMeLogger.logWithException(
          message: "Unable to generate output path for image", e: e);
    }
    return generatePath(inputFilePath);
  }
}
