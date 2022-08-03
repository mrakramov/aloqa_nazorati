import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDB {
  late Box _box;

  Future<void> hiveInit() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      _box = await Hive.openBox(Strings.dbBoxName);
      if (kDebugMode) {
        print('db inited');
      }
    } catch (e) {
      if (kDebugMode) {
        print("exception");
      }
    }
  }

  Box get box => _box;
}
