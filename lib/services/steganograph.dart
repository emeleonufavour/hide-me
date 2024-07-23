import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
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

  static Future<File?> _encodeMessageInIsolate(
      File file, String message, String password) async {
    return await encodeMessage(file, message, password);
  }

  static _isolateEntryPoint(SendPort sendPort) async {
    try {
      RootIsolateToken rootToken = RootIsolateToken.instance!;
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
      final port = ReceivePort();
      sendPort.send(port.sendPort);

      await for (final msg in port) {
        if (msg is List) {
          final File file = msg[0];
          final String message = msg[1];
          final String password = msg[2];
          final SendPort replyPort = msg[3];

          try {
            final result =
                await _encodeMessageInIsolate(file, message, password);
            replyPort.send(result);
          } catch (e) {
            HideMeLogger.logWithException(
                message: "Error encoding message in isolate", e: e);
            replyPort.send(null);
          }
        }
      }
    } catch (e) {
      HideMeLogger.logWithException(
          message: "Error while running _isolateEntryPoint", e: e);
    }
  }

  static Future<File?> encodeMessageWithIsolate(
      File imageFile, String message, String password) async {
    final completer = Completer<File?>();
    final port = ReceivePort();

    await Isolate.spawn(_isolateEntryPoint, port.sendPort);

    final sendPort = await port.first as SendPort;
    final responsePort = ReceivePort();

    sendPort.send([imageFile, message, password, responsePort.sendPort]);

    responsePort.listen((result) {
      completer.complete(result as File?);
    });

    return completer.future;
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
