

import 'package:nfc_smart_attendance/helpers/base_api_response.dart';
import 'package:nfc_smart_attendance/models/attendance_history/attendance_history_model.dart';
import 'package:nfc_smart_attendance/models/paginator_model.dart';

class ListAttendanceHistoryResponseModel extends BaseAPIResponse<List<AttendanceHistoryModel>, Null> {
  ListAttendanceHistoryResponseModel(fullJson) : super(fullJson);

  @override
  dataToJson(List<AttendanceHistoryModel>? data) {
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
  List<AttendanceHistoryModel>? jsonToData(Map<String, dynamic>? json) {
    if (json != null) {
      data = [];

      json["data"].forEach((v) {
        data!.add(AttendanceHistoryModel.fromJson(v));
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
