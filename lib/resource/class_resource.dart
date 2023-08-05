import 'dart:convert';

import 'package:nfc_smart_attendance/models/attendance_history/list_attendance_history_response_model.dart';
import 'package:nfc_smart_attendance/models/class_today/list_class_today_response_model.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/models/request_exemption/request_exemption_request_model.dart';
import 'package:nfc_smart_attendance/services/resource.dart';

class ClassResource {
  static Resource getListClassToday() {
    return Resource(
        url: 'classrooms',
        parse: (response) {
          return ListClassTodayResponseModel(json.decode(response.body));
        });
  }
  static Resource getListAttendanceHistory() {
    return Resource(
        url: 'history',
        parse: (response) {
          return ListAttendanceHistoryResponseModel(json.decode(response.body));
        });
  }
  static Resource attendClass(int classRoomsId) {
    return Resource(
        url: 'classrooms/$classRoomsId/attend_class',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
  static Resource requestExemption(RequestExemptionRequestModel requestExemptionRequestModel, int attendanceHistoryId) {
    return Resource(
        url: 'history/$attendanceHistoryId/upload_exemption',
        data: requestExemptionRequestModel.toJson(),
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
}
