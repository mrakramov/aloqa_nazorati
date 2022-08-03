import 'package:aloqa_nazorati/utils/db/regions_data.dart';
import 'package:get_it/get_it.dart';

import '../db/hive_db.dart';

GetIt serviceLocator = GetIt.instance;

void setup() async {
  serviceLocator.registerSingleton<HiveDB>(HiveDB());
  await serviceLocator.get<HiveDB>().hiveInit();
  await RegionsData.writeDataToDb();
}
