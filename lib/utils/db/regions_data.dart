import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/utils/db/hive_db.dart';
import 'package:aloqa_nazorati/utils/di/locator.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class RegionsData {
  static Future<void> writeDataToDb() async {
    try {
      final AppealRepository repo = AppealRepository();
      final response = await repo.getRegions();
      final Box box = serviceLocator.get<HiveDB>().box;

      await box.put(
          Strings.regionsDataKey, response.map((e) => e.toJson()).toList());

      if (kDebugMode) {
        print('regionlar saqlandi');
      }
    } catch (e) {}
  }
}
