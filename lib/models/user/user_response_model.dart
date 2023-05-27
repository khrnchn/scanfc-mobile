import 'package:nfc_smart_attendance/helpers/base_api_response.dart';
import 'package:nfc_smart_attendance/models/paginator_model.dart';

import 'package:nfc_smart_attendance/models/user/user_model.dart';

class UserResponseModel extends BaseAPIResponse<UserModel, Null> {
  UserResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(UserModel? data) {
    if (this.data != null) {
      return this.data!.toJson();
    }
    return null;
  }

  @override
  errorsToJson(Null errors) {
    return null;
  }

  @override
  UserModel? jsonToData(Map<String, dynamic>? json) {
    return json!["data"] != null ? UserModel.fromJson(json["data"]) : null;
  }

  @override
  Null jsonToError(Map<String, dynamic> json) {
    return null;
  }

  @override
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel) {
    throw UnimplementedError();
  }
}
