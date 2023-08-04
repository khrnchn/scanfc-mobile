import 'package:nfc_smart_attendance/models/subject/subject_model.dart';

class SectionModel {
  String? sectionName;
  String? subjectName;
  String? lecturerName;
  SubjectModel? subject;

  SectionModel(
      {this.sectionName, this.subjectName, this.lecturerName, this.subject});

  SectionModel.fromJson(Map<String, dynamic> json) {
    sectionName = json['section_name'];
    subjectName = json['subject_name'];
    lecturerName = json['lecturer_name'];
    subject =
        json['subject'] != null ? new SubjectModel.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_name'] = this.sectionName;
    data['subject_name'] = this.subjectName;
    data['lecturer_name'] = this.lecturerName;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    return data;
  }
}