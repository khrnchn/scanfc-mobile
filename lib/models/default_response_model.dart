import 'package:nfc_smart_attendance/helpers/base_api_response.dart';
import 'package:nfc_smart_attendance/models/paginator_model.dart';

class DefaultResponseModel extends BaseAPIResponse<dynamic, Null> {
  DefaultResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(data) {
    return null;
  }

  @override
  errorsToJson(errors) {
    return null;
  }

  @override
  jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      return json["data"];
    }
  }

  @override
  jsonToError(Map<String, dynamic> json) {
    return null;
  }

  @override
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json) {
    return null;
  }

  @override
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel) {
    return null;
  }
}
