import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class FilePath {
  static Future<String> getFilePath(
      String imagePath, String fileSubPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileSubPath.png';

    final bytes = await rootBundle.load(imagePath);
    final buffer = bytes.buffer;
    final file = File(filePath);
    await file.writeAsBytes(
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    return filePath;
  }
}
