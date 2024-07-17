import 'dart:io';

import 'package:image/image.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

class ImageHelper {
  Future<Image?> convertToPng(File img) async {
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
    }
  }

  String getImageType(String imgPath) {
    try {
      return imgPath
          .split(Platform.pathSeparator)
          .last
          .split(".")
          .last
          .toLowerCase();
    } catch (e) {
      throw Exception("Error while getting file type");
    }
  }
}
