import '../data/model/AppealResponse.dart';

abstract class AppealRepo {
  Future<AppealResponse> appeals(String token);
}
