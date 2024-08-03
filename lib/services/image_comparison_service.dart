import 'dart:io';

import 'package:image/image.dart' as img;

class ImageComparisonService {
  static String compareImages(File referenceImage, List<File> shelfImages) {
    String result = "Comparison Results:\n";

    // Example: Compare dimensions (You can extend this to more complex comparisons)
    final refImg = img.decodeImage(referenceImage.readAsBytesSync());
    for (int i = 0; i < shelfImages.length; i++) {
      final shelfImg = img.decodeImage(shelfImages[i].readAsBytesSync());
      if (refImg!.width == shelfImg!.width &&
          refImg.height == shelfImg.height) {
        result += "Image ${i + 1}: Dimensions Match\n";
      } else {
        result += "Image ${i + 1}: Dimensions Do Not Match\n";
      }
    }

    return result;
  }
}
