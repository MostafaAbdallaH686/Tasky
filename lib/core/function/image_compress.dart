import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

Future<File> compressImage(File file) async {
  final dir = await getTemporaryDirectory();
  final targetPath = '${dir.path}/${const Uuid().v4()}.jpg';

  final XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 60,
    minWidth: 800,
    minHeight: 800,
  );

  if (compressedXFile != null) {
    return File(compressedXFile.path);
  } else {
    return file;
  }
}
