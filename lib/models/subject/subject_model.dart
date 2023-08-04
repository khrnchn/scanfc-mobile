class SubjectModel {
  String? name;
  String? code;
  String? facultyName;
  String? facultyCode;

  SubjectModel({this.name, this.code, this.facultyName, this.facultyCode});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    facultyName = json['faculty_name'];
    facultyCode = json['faculty_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['faculty_name'] = this.facultyName;
    data['faculty_code'] = this.facultyCode;
    return data;
  }
}