import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hide_me/exceptions.dart';
import 'package:image/image.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

class ImageHelper {
  static const MethodChannel _channel = MethodChannel("heic_to_png");

  static const List<String> _supportedImageTypes = [
    "heic",
    "jpg",
    "jpeg",
    "png"
  ];

  static bool isImage(String path) {
    return _supportedImageTypes.contains(
      getImageType(path),
    );
  }

  static Future<Image?> convertToPng(File img) async {
    String imgType = getImageType(img.path);

    switch (imgType) {
      case "png":
        return decodePng(await img.readAsBytes());
      case "jpg":
      case "jpeg":
        final Image? jpegImg = decodeJpg(await img.readAsBytes());
        final Size size = ImageSizeGetter.getSize(FileInput(img));

        final newImg = Image.fromBytes(
            width: size.width,
            height: size.height,
            bytes: jpegImg!.getBytes().buffer);

        final pngBytes = encodePng(newImg);

        return decodePng(pngBytes);
      case "heic":
        final Image? heicImage = await decodeHeic(img);
        if (heicImage == null) {
          throw Exception("Failed to decode HEIC image.");
        }

        final pngBytes = encodePng(heicImage);
        return decodePng(pngBytes);
      default:
        throw UnsupportedError("Unsupported image type: $imgType");
    }
  }

  static Future<Image?> decodeHeic(File heicFile) async {
    if (Platform.isIOS) {
      final String? pngFilePath = await _channel.invokeMethod('convert', {
        'filePath': heicFile.path,
      });

      if (pngFilePath == null) {
        return null;
      }

      final pngFile = File(pngFilePath);
      return decodePng(await pngFile.readAsBytes());
    } else {
      throw HideMeLogger.logMessage(
        message:
            "Only IOS devices is supported in decoding HEIC files at the moment",
      );
    }
  }

  static String getImageType(String imgPath) {
    try {
      final extension = imgPath
          .split(Platform.pathSeparator)
          .last
          .split(".")
          .last
          .toLowerCase();
      switch (extension) {
        case 'png':
          return 'png';
        case 'jpg':
        case 'jpeg':
          return 'jpg';
        case 'heic':
          return 'heic';
        default:
          return 'unknown';
      }
    } catch (e) {
      throw HideMeLogger.logWithException(
          message: "Error while getting file type", e: e);
    }
  }
}
