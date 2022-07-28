import 'package:aloqa_nazorati/screens/auth/data/model/UserDataResponse.dart';

abstract class AuthState {
  AuthState();
}

class InitialState extends AuthState {
  InitialState();
}

class SuccessState extends AuthState {
  final UserDataResponse response;

  SuccessState(this.response);
}

class UploadingState extends AuthState {
  final bool isLoading;

  UploadingState(this.isLoading);
}

class ErrorState extends AuthState {
  final dynamic error;
  ErrorState(this.error);
}
