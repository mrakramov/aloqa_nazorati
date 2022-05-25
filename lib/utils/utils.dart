
import 'package:shared_preferences/shared_preferences.dart';

class Strings {

  static const connectionError = "Internet bilan uzulish mavjud !";
  static const clientError = "Ma'lumotlar topilmadi !";
  static const serverError = "Server bilan uzulish mavjud !";
  static const unknownError = "Kutilmagan xatolik yuz berdi ! ";
  static const emptyResultError = "Ma'lumot mavjud emas";

}


// class Prefs{
//
//   static Future<bool> save(String key , String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setString(key, value);
//   }
//
//   static Future<String> load(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString(key) ?? "";
//     return token;
//   }
//
//   static Future<bool> remove(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.remove(key);
//   }
//
// }

// abstract class ApiExceptionMapper {
//   static String toErrorMessage(Object error) {
//     if (error is ApiException) {
//       if (error is ConnectionException) {
//         return Strings.connectionError;
//       } else if (error is ClientErrorException) {
//         return Strings.clientError;
//       } else if (error is ServerErrorException) {
//         return Strings.serverError;
//       } else if (error is EmptyResultException) {
//         return Strings.emptyResultError;
//       } else {
//         return Strings.unknownError;
//       }
//     } else {
//       return "No Connection";
//     }
//   }
// }