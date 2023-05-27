// Register response model
import 'package:nfc_smart_attendance/helpers/base_api_response.dart';
import 'package:nfc_smart_attendance/models/paginator_model.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';

class RegisterResponseModel extends BaseAPIResponse<UserModel, Errors> {
  RegisterResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(UserModel? data) {
    if (this.data != null) {
      return this.data!.toJson();
    }
    return null;
  }

  @override
  errorsToJson(Errors? errors) {
    if (this.errors != null) {
      return this.errors!.toJson();
    }
    return null;
  }

  @override
  UserModel? jsonToData(Map<String, dynamic>? json) {
    return json!["data"] != null ? UserModel.fromJson(json["data"]) : null;
  }

  @override
  Errors? jsonToError(Map<String, dynamic>? json) {
    return json != null ? Errors.fromJson(json) : null;
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

// Errors from response
class Errors {
  List<String>? name;
  List<String>? email;
  List<String>? password;

  Errors({this.name, this.email, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name'].cast<String>();
    email = json['email'].cast<String>();
    password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
