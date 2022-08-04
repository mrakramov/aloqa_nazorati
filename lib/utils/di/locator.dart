import 'package:aloqa_nazorati/utils/db/regions_data.dart';
import 'package:aloqa_nazorati/utils/file/file_service.dart';
import 'package:get_it/get_it.dart';

import '../db/hive_db.dart';

GetIt serviceLocator = GetIt.instance;

void setup() async {
  serviceLocator.registerLazySingleton<FileRepo>(() => FileRepo());
  serviceLocator.registerSingleton<HiveDB>(HiveDB());
  await serviceLocator.get<HiveDB>().hiveInit();
  await RegionsData.writeDataToDb();
}
