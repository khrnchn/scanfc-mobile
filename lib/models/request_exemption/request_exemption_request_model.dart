import 'package:image_picker/image_picker.dart';

class RequestExemptionRequestModel {
  XFile? exemptionFile;
  String? remarks;

  RequestExemptionRequestModel({this.exemptionFile, this.remarks});

  RequestExemptionRequestModel.fromJson(Map<String, dynamic> json) {
    // exemptionFile = json['exemption_file'];
    remarks = json['exemption_remarks'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    // data['exemption_file'] = this.exemptionFile;
    data['exemption_remarks'] = this.remarks!;
    return data;
  }
}
