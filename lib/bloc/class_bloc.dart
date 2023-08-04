import 'package:nfc_smart_attendance/models/attendance_history/list_attendance_history_response_model.dart';
import 'package:nfc_smart_attendance/models/class_today/list_class_today_response_model.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/resource/class_resource.dart';
import 'package:nfc_smart_attendance/services/web_services.dart';

class ClassBloc {
  Future<ListClassTodayResponseModel> getListClassToday() async {
    return await Webservice.get(ClassResource.getListClassToday());
  }

  Future<ListAttendanceHistoryResponseModel> getListAttendanceHistory() async {
    return await Webservice.get(ClassResource.getListAttendanceHistory());
  }
  Future<DefaultResponseModel> attendClass(int classRoomsId) async {
    return await Webservice.post(ClassResource.attendClass(classRoomsId));
  }
}
