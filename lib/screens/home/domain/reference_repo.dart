import 'package:aloqa_nazorati/screens/home/data/model/reference_list_response.dart';
import 'package:aloqa_nazorati/screens/home/data/model/reference_response_model.dart';
import 'package:aloqa_nazorati/screens/home/data/model/reference_send_model.dart';

abstract class ReferenceRepo {
  Future<List<ReferenceListResponse>> references();

  Future<List<ReferenceListResponse>> referencesServiceList(int id);
  Future<ReferenceResponseModel> referencesSendingMethod(
      {required ReferenceSendModel? model});
}
