import 'package:nfc_smart_attendance/helpers/base_api_response.dart';
import 'package:nfc_smart_attendance/models/paginator_model.dart';

class ValidatePasswordResponseModel
    extends BaseAPIResponse<Null, ValidatePasswordErrorsModel> {
  ValidatePasswordResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(Null? data) {
    return null;
  }

  @override
  errorsToJson(ValidatePasswordErrorsModel? errors) {
    if (this.errors != null) {
      return this.errors!.toJson();
    }
    return null;
  }

  @override
  Null jsonToData(Map<String, dynamic>? json) {
    return null;
  }

  @override
  ValidatePasswordErrorsModel? jsonToError(Map<String, dynamic>? json) {
    return json != null ? ValidatePasswordErrorsModel.fromJson(json) : null;
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

class ValidatePasswordErrorsModel {
  List<String>? currentPassword;

  ValidatePasswordErrorsModel({this.currentPassword});

  ValidatePasswordErrorsModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['current_password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_password'] = this.currentPassword;
    return data;
  }
}
