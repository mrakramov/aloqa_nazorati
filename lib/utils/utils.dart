import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void log(Object? msg) {
  if (kDebugMode) {
    print(msg);
  }
}

class Strings {
  static const dbBoxName = 'region_db';
  static const regionsDataKey = 'regions_data';
  static const connectionError = "Internet bilan uzulish mavjud !";
  static const clientError = "Ma'lumotlar topilmadi !";
  static const serverError = "Server bilan uzulish mavjud !";
  static const unknownError = "Kutilmagan xatolik yuz berdi ! ";
  static const emptyResultError = "Ma'lumot mavjud emas";
  static const webApiKey = "xnazorat-3a63daeb0f10ed0f104cc9a2406c9988-mobile";

  static const stepOneTitle = "Ro’yxatdan o’ting";
  static const stepOneContent =
      "Mobil ilovadan foydalanish uchun avtorizatsiyadan oʻting yoki mavjud profilingiz orqali tizimga kiring";

  static const stepTwoTitle = "Muammo bo’yicha xabar bering";
  static const stepTwoContent =
      "Axborotlashtirish va telekommunikatsiyalar sohasida mavjud muammolar haqida xabar bering";

  static const stepThreeTitle = "Muammo yechilishi bo’yicha natijani kuting";
  static const stepThreeContent =
      "Oʻzkomnazorat tomonidan muammo va murojaatingiz boʻyicha rasmiy javob berilishini kuting\n";

  static const stepFourTitle = "Natijani ko’ring";
  static const stepFourContent =
      "Sizning muammongiz xal etilishi bo’yicha natija bilan tanishing va tizimga o’z bahoingizni qo’ying";
  static List<String>? listFileTypes = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'jpg',
    'jpeg',
    'png'
  ];
}

class NumberUtil {
  static String? getSortedPhoneNumber(String s) {
    s = s.substring(4);

    var newNum = '';
    for (var i = 0; i < s.length; i++) {
      if (i == 2) {
        newNum += ' ';
      }

      if (i == 5 || i == 7) {
        newNum += '-';
      }
      newNum += s[i];
    }
    return newNum;
  }
}

class FileManagementService {
  // static Future<File> writeFile(Uint8List data, String name) async {
  //   // storage permission ask
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }
  //   // the downloads folder path
  //   // Directory? tempDir = await DownloadsPathProvider.downloadsDirectory;
  //   // String tempPath = tempDir!.path;
  //   // var filePath = '$tempPath/$name';
  //   //

  //   // the data
  //   var bytes = ByteData.view(data.buffer);
  //   final buffer = bytes.buffer;
  //   // save the data in the path
  //   return File(filePath).writeAsBytes(
  //       buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  // }

}

class ColorsUtils {
  static const myColor = Color.fromRGBO(68, 30, 221, 1);
  static const Color buttonColor = Color(0xFF504aba);
}

class Prefs {
  static Future<bool> save(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String> load(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(key) ?? "";
    return token;
  }

  static Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

abstract class ApiException implements Exception {}

class EmptyResultException extends ApiException {}

class ConnectionException extends ApiException {}

class ServerErrorException extends ApiException {}

class ClientErrorException extends ApiException {}

class UnknownException extends ApiException {}

abstract class ApiExceptionMapper {
  static String toErrorMessage(Object error) {
    if (error is ApiException) {
      if (error is ConnectionException) {
        return Strings.connectionError;
      } else if (error is ClientErrorException) {
        return Strings.clientError;
      } else if (error is ServerErrorException) {
        return Strings.serverError;
      } else if (error is EmptyResultException) {
        return Strings.emptyResultError;
      } else {
        return Strings.unknownError;
      }
    } else {
      return "No Connection";
    }
  }
}
