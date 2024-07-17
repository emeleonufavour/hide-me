import 'dart:io';

import 'package:hide_me/services/exceptions.dart';
import 'package:hide_me/helpers/img_helper.dart';

class FileHelper {
  static String? generatePath(String path) {
    try {
      final fileName = "${DateTime.now().toIso8601String()}.png";

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
