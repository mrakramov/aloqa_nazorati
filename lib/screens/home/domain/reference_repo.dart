import 'package:aloqa_nazorati/screens/home/data/model/reference_list_response.dart';

abstract class ReferenceRepo {
  Future<List<ReferenceListResponse>> references();

  Future<List<ReferenceListResponse>> referencesServiceList(int id);
}
