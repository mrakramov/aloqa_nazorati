import 'package:aloqa_nazorati/screens/auth/data/model/UserDataResponse.dart';

abstract class AuthRepo {
  Future<UserDataResponse> userData(String code);
}
