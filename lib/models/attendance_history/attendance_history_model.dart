import 'package:nfc_smart_attendance/models/class_today/class_today_model.dart';

class AttendanceHistoryModel {
  int? id;
  String? attendanceStatus;
  String? exemptionStatus;
  ClassTodayModel? classroom;

  AttendanceHistoryModel(
      {this.id, this.attendanceStatus, this.exemptionStatus, this.classroom});

  AttendanceHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceStatus = json['attendance_status'];
    exemptionStatus = json['exemption_status'];
    classroom = json['classroom'] != null
        ? new ClassTodayModel.fromJson(json['classroom'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attendance_status'] = this.attendanceStatus;
    data['exemption_status'] = this.exemptionStatus;
    if (this.classroom != null) {
      data['classroom'] = this.classroom!.toJson();
    }
    return data;
  }
}
