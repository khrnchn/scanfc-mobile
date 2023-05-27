class UpdateUserRequestModel {
  String? name;
  int? title;
  String? address;
  String? phoneNo;
  int? worldDivisionId;

  UpdateUserRequestModel(
      {this.name,
      this.title,
      this.address,
      this.phoneNo,
      this.worldDivisionId});

  UpdateUserRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    address = json['address'];
    phoneNo = json['phone_no'];
    worldDivisionId = json['world_division_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['address'] = this.address;
    data['phone_no'] = this.phoneNo;
    data['world_division_id'] = this.worldDivisionId;
    return data;
  }
}
