import 'package:aloqa_nazorati/screens/auth/data/network/auth_repository.dart';
import 'package:aloqa_nazorati/screens/auth/pages/bloc/auth_state.dart';
import 'package:aloqa_nazorati/screens/home/data/network/reference_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(InitialState());

  void userData(String code) async {
    emit(InitialState());
    try {
      emit(UploadingState(true));
      var result = await repository.userData(code);
      if (result.token.isNotEmpty) {
        emit(UploadingState(false));
        emit(SuccessState(result));
      } else {
        emit(UploadingState(false));
        emit(ErrorState(result));
      }
    } catch (e) {
      emit(UploadingState(false));
      emit(ErrorState(e));
    }
  }
}
