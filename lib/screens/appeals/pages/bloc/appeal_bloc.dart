import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/bloc/appeal_state.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppealBloc extends Cubit<AppealState> {
  final AppealRepository repository;

  AppealBloc(this.repository) : super(InitialState());

  void appeals(Future<String> token) async {
    emit(InitialState());
    try {
      var t = await token;
      log("log   $t");
      emit(UploadingState(true));
      var result = await repository.appeals(
        t,
      );
      log("DATAAA::$result");
      if (result.data!.isNotEmpty) {
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

  @override
  void onChange(Change<AppealState> change) {
    if (kDebugMode) {
      print(change.nextState);
    }
    super.onChange(change);
  }
}
