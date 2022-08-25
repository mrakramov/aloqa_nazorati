import 'package:aloqa_nazorati/screens/appeals/data/model/response_file_model.dart';
import 'package:aloqa_nazorati/screens/appeals/data/network/appeal_repository.dart';
import 'package:aloqa_nazorati/screens/appeals/data/model/appeal_send_model.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal/bloc/appeal_send_state.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppealSendCubit extends Cubit<AppealSendState> {
  AppealRepository repository;
  final List<FileUploadResponseModel?> _listFile = [];
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

  void appealsUpload(AppealRequestData? appeal, BuildContext context) async {
    if (kDebugMode) {
      print(await Prefs.load("token"));
    }
    try {
      emit(LoadingState(true));
      var token = await Prefs.load("token");
      appeal!.setFile = List<int>.from(_listFile.map<int?>((e) => e!.data!.id));

      if (kDebugMode) {
        print(appeal.toJson());
      }
      final response =
          await repository.appealSendingMethod(model: appeal, token: token);
      if (kDebugMode) {
        print("APPEAL:${response.data}");
      }
      if (response.data!.isSend!) {
        _listFile.clear();
        emit(LoadingState(false));
        emit(FileUploadState(file: []));
        emit(SuccessState(response));
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Murojat xolati',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Card(
              elevation: .0,
              child: Text(
                'Sizning murojatingiz muvofaqqiyatli ravishda tizimga yuborildi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: ColorsUtils.myColor),
                  ))
            ],
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print("EXCEPTIONNNNNN");
      }
      emit(ErrorState(e));
    }
  }

  Future<void> uploadFile({required String? filePath}) async {
    try {
      emit(LoadingState(true));
      var token = await Prefs.load("token");
      final response =
          await repository.uploadFile(token: token, file: filePath);
      _listFile.add(response);
      if (kDebugMode) {
        print("IDDDD------>${response.data!.id!}");
      }
      emit(LoadingState(false));
      emit(FileUploadState(file: _listFile));
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print("EXCEPTIONNNNNN");
      }
      emit(ErrorState(e));
    }
  }

  void removeFile({required int index}) async {
    try {
      emit(LoadingState(true));
      if (_listFile.isNotEmpty) {
        _listFile.removeAt(index);
      }
      emit(LoadingState(false));
      emit(FileUploadState(file: _listFile));
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
