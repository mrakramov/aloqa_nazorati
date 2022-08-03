import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/reference_send_model.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/reference_send_state.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ReferenceSendCubit extends Cubit<ReferenceSendState> {
  AppealRepository repository;
  ReferenceSendCubit(this.repository) : super(InitialState());
  void getRegions() async {
    emit(InitialState());
    try {
      emit(LoadingState(true));
      final response = await repository.getRegions();
      if (kDebugMode) {
        // for (var element in response) {
        //   print(element.id);
        // }

      }
      if (response.isNotEmpty) {
        emit(LoadingState(false));
        emit(RegionsSuccessState(response));
      } else {
        emit(LoadingState(false));
        emit(ErrorState(response));
      }
    } catch (e) {
      emit(ErrorState(e));
    }
  }

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

  void referencesUpload() async {
    if (kDebugMode) {
      print(await Prefs.load("token"));
    }
    try {
      emit(LoadingState(true));
      ReferenceSendModel? model = ReferenceSendModel.fromJson({
        "letter_id": 1,
        "description": "long long text goes here",
        "first_name": "Somebody",
        "last_name": "Something",
        "address": "Somewhere",
        "ticket_region_id": 3,
        "ticket_district_id": 180,
        "phone": "99 999-99-99",
        "reference_parent_id": 3,
        "reference_id": 33,
        "files[]": [15, 16, 17]
      });
      final response = await repository.referencesSendingMethod(
          model: model, token: await Prefs.load("token"));
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
      emit(ErrorState(e.toString()));
    }
  }

  @override
  void onChange(Change<ReferenceSendState> change) {
    if (kDebugMode) {
      print(change);
    }
    super.onChange(change);
  }
}
