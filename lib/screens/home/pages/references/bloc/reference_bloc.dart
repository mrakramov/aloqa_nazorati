import 'package:aloqa_nazorati/screens/home/data/network/reference_repository.dart';
import 'package:aloqa_nazorati/screens/home/pages/references/bloc/reference_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReferenceBloc extends Cubit<ReferenceState> {
  final ReferenceRepository repository;

  ReferenceBloc(this.repository) : super(InitialState());

  void references() async {
    emit(InitialState());
    try {
      emit(UploadingState(true));
      var result = await repository.references();
      if (result.isNotEmpty) {
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
