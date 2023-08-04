import 'package:nfc_smart_attendance/models/section/section_model.dart';

class ClassTodayModel {
  int? id;
  String? sectionName;
  String? venueName;
  String? classroomName;
  int? classroomType;
  String? startAt;
  String? endAt;
  String? attendanceStatus;
  SectionModel? section;

  ClassTodayModel(
      {this.id,
      this.sectionName,
      this.venueName,
      this.classroomName,
      this.classroomType,
      this.startAt,
      this.endAt,
      this.attendanceStatus,
      this.section});

  ClassTodayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionName = json['section_name'];
    venueName = json['venue_name'];
    classroomName = json['classroom_name'];
    classroomType = json['classroom_type'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    attendanceStatus = json['attendance_status'];
    section =
        json['section'] != null ? new SectionModel.fromJson(json['section']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section_name'] = this.sectionName;
    data['venue_name'] = this.venueName;
    data['classroom_name'] = this.classroomName;
    data['classroom_type'] = this.classroomType;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['attendance_status'] = this.attendanceStatus;
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    return data;
  }
}