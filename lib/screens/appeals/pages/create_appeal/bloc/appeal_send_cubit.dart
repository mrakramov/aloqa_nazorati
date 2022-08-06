import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/appeal_send_model.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/appeal_send_state.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppealSendCubit extends Cubit<AppealSendState> {
  AppealRepository repository;
  AppealSendCubit(this.repository) : super(InitialState());

  void getDistricts(int? regionId) async {
    try {
      emit(LoadingState(true));
      final districtResponse = await repository.getDistricts(regionId);
      if (districtResponse.isNotEmpty) {
        emit(LoadingState(false));
        emit(DistrictSuccessState(districtResponse, districtResponse.first));
      } else {
        emit(LoadingState(false));
        emit(ErrorState(districtResponse));
      }
    } catch (e) {
      emit(ErrorState(e));
    }
  }

  void appealsUpload(AppealRequestData? appeal) async {
    if (kDebugMode) {
      print(await Prefs.load("token"));
    }
    try {
      emit(LoadingState(true));
      var token = await Prefs.load("token");
      final response =
          await repository.appealSendingMethod(model: appeal, token: token);
      if (kDebugMode) {
        print(response.data.firstName);
      }
      emit(LoadingState(false));
      emit(SuccessState(response));
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print("EXCEPTIONNNNNN");
      }
      emit(ErrorState(e));
    }
  }

  @override
  void onChange(Change<AppealSendState> change) {
    if (kDebugMode) {
      print(change);
    }
    super.onChange(change);
  }
}
