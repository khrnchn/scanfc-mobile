

import 'package:nfc_smart_attendance/helpers/base_api_response.dart';
import 'package:nfc_smart_attendance/models/class_today/class_today_model.dart';
import 'package:nfc_smart_attendance/models/paginator_model.dart';

class ListClassTodayResponseModel extends BaseAPIResponse<List<ClassTodayModel>, Null> {
  ListClassTodayResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<ClassTodayModel>? data) {
    if (this.data != null) {
      return this.data?.map((v) => v.toJson()).toList();
    }
    return null;
  }

  @override
  errorsToJson(Null errors) {
    return null;
  }

  @override
  List<ClassTodayModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(ClassTodayModel.fromJson(v));
      });

      return data!;
    }

    return null;
  }

  @override
  Null jsonToError(Map<String, dynamic> json) {
    return null;
  }

  @override
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json) {
    // Convert json["paginator"] data to PaginatorModel
    if (json["paginator"] != null) {
      return PaginatorModel.fromJson(json["paginator"]);
    }
    return null;
  }

  @override
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel) {
    return null;
  }
}
