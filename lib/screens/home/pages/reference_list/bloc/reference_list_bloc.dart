import 'package:aloqa_nazorati/screens/home/data/network/reference_repository.dart';
import 'package:aloqa_nazorati/screens/home/pages/reference_list/bloc/reference_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReferenceListBloc extends Cubit<ReferenceListState> {
  final ReferenceRepository repository;

  ReferenceListBloc(this.repository) : super(InitialState());

  void referencesServiceList(int id) async {
    emit(InitialState());
    try {
      emit(UploadingState(true));
      var result = await repository.referencesServiceList(id);
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
