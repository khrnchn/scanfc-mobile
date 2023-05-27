class PaginatorModel {
  int? total;
  int? count;
  int? lastPage;
  int? perPage;

  PaginatorModel({this.total, this.count, this.lastPage, this.perPage});

  PaginatorModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    lastPage = json['lastPage'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['lastPage'] = this.lastPage;
    data['perPage'] = this.perPage;
    return data;
  }
}
