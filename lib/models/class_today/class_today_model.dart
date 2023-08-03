class ClassTodayModel {
  int? id;
  String? sectionId;
  String? venueId;
  String? name;
  int? type;
  String? startAt;
  String? endAt;

  ClassTodayModel(
      {this.id,
      this.sectionId,
      this.venueId,
      this.name,
      this.type,
      this.startAt,
      this.endAt});

  ClassTodayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    venueId = json['venue_id'];
    name = json['name'];
    type = json['type'];
    startAt = json['start_at'];
    endAt = json['end_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section_id'] = this.sectionId;
    data['venue_id'] = this.venueId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    return data;
  }
}
