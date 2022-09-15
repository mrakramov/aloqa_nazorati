import 'package:aloqa_nazorati/utils/db/regions_data.dart';
import 'package:aloqa_nazorati/utils/file/file_service.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get_it/get_it.dart';

import '../db/hive_db.dart';

GetIt serviceLocator = GetIt.instance;
//service locator
get setup async {
  serviceLocator.registerLazySingleton<FileRepo>(() => FileRepo());
  serviceLocator.registerSingleton<HiveDB>(HiveDB());
  await serviceLocator.get<HiveDB>().hiveInit();
  await RegionsData.writeDataToDb();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
}
