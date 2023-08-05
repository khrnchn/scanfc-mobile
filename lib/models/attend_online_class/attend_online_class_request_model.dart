class AttendOnlineClassRequestModel {
  String? classroomId;

  AttendOnlineClassRequestModel({this.classroomId});

  AttendOnlineClassRequestModel.fromJson(Map<String, dynamic> json) {
    classroomId = json['classroom_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classroom_id'] = this.classroomId;
    return data;
  }
}
