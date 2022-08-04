import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class FileService {
  Future<void> pickFiles();
}

abstract class FileSaver {
  Future<void> saveFiles();
}

class FileRepo implements FileService, FileSaver {
  @override
  Future<FilePickerResult?> pickFiles() async {
    try {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
      if (await Permission.mediaLibrary.isDenied) {
        await Permission.mediaLibrary.request();
      }

      FilePickerResult? results = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            'pdf',
            'doc',
            'docx',
            'xls',
            'jpg',
            'jpeg',
            'png'
          ]);
      return results;
    } catch (e, s) {
      if (kDebugMode) {
        print(s);
        print("File sysytem bilan bog`liq xatolik $e");
      }
    }
    return null;
  }

  @override
  Future<void> saveFiles() async {
    try {} catch (e) {}
  }
}
