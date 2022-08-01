import 'package:aloqa_nazorati/screens/home/data/model/reference_send_model.dart';
import 'package:aloqa_nazorati/screens/home/data/network/reference_repository.dart';
import 'package:aloqa_nazorati/screens/home/pages/reference_send/bloc/reference_send_state.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ReferenceSendCubit extends Cubit<ReferenceSendState> {
  ReferenceRepository repository;
  ReferenceSendCubit(this.repository) : super(InitialState());

  void referencesUpload() async {
    try {
      emit(LoadingState(true));
      ReferenceSendModel? model = ReferenceSendModel.fromJson({
        "letter_id": 10,
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
      final response = await repository.referencesSendingMethod(model: model);
      if (kDebugMode) {
        print(response.firstName);
      }
      emit(SuccessState(response));
      emit(LoadingState(false));
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print("EXCEPTIONNNNNN");
      }
      emit(ErrorState());
    }
  }

  @override
  void onChange(Change<ReferenceSendState> change) {
    if (kDebugMode) {
      print(change.currentState);
    }
    super.onChange(change);
  }
}
