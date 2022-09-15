import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/response_bloc/appeal_single_response_state.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleAppealCubit extends Cubit<AppealSingleResponseState> {
  final AppealRepository repository;
  SingleAppealCubit(this.repository) : super(InitialSingleState());

  void singleAppeal(Future<String> token, String? code) async {
    emit(InitialSingleState());
    try {
      var t = await token;
      log("log   $t");
      emit(LoadingState(true));
      var result = await repository.getSingleAppeal(token: t, code: code);
      log("DATAA#::$result");
      if (result.data!.userFiles!.isNotEmpty) {
        emit(LoadingState(false));
        emit(SuccesState(result));
      } else {
        log('SECOND');
        emit(LoadingState(false));
        emit(ErrorState(result));
      }
    } catch (e) {
      emit(LoadingState(false));
      emit(ErrorState(e));
    }
  }

  void downloadFileToStorage(
      {required Future<String> token,
      required String? fileName,
      String? code}) async {
    var t = await token;
    try {
      emit(LoadingState(true));
      var data = await repository.downloadFileUsingDownloader(
          fileName: fileName, token: t);
      log(data);
      if (data != null) {
        emit(LoadingState(false));
        emit(DownloadState(taskId: data));
      }
      singleAppeal(token, code);
    } catch (e) {
      emit(ErrorState(e));
    }
  }

  @override
  void onChange(Change<AppealSingleResponseState> change) {
    log(change);
    super.onChange(change);
  }
}
