import 'package:aloqa_nazorati/screens/home/data/model/reference_response_model.dart';

abstract class ReferenceSendState {
  ReferenceSendState();
}

class InitialState extends ReferenceSendState {
  InitialState();
}

class SuccessState extends ReferenceSendState {
  ReferenceResponseModel? response;
  SuccessState(this.response);
}

class LoadingState extends ReferenceSendState {
  bool? isLoading;
  LoadingState(this.isLoading);
}

class ErrorState extends ReferenceSendState {
  ErrorState();
}
