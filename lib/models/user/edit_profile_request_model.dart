import 'package:image_picker/image_picker.dart';
import 'package:nfc_smart_attendance/models/user/update_user_request_model.dart';
import 'package:image_pickers/image_pickers.dart';

class EditProfileRequestModel {
  String? accountNumber;
  String? bankId;
  // UpdateUserRequestModel? user;
  XFile? photoPath;
  String? name;
  String? title;
  String? address;
  String? phoneNo;
  String? worldDivisionId;

  EditProfileRequestModel({
    this.accountNumber,
    this.bankId,
    // this.user,
    this.photoPath,
    this.name,
    this.title,
    this.address,
    this.phoneNo,
    this.worldDivisionId,
  });

  EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    bankId = json['bank_id'];
    // user = json['user'] != null
    //     ? new UpdateUserRequestModel.fromJson(json['user'])
    //     : null;
    // photoPath = json['photo_path'];
    name = json['name'];
    title = json['title'];
    address = json['address'];
    phoneNo = json['phone_no'];
    worldDivisionId = json['world_division_id'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['account_number'] = this.accountNumber!;
    data['bank_id'] = this.bankId ?? "";
    data['name'] = this.name ?? "";
    data['title'] = this.title ?? "";
    data['address'] = this.address ?? "";
    data['phone_no'] = this.phoneNo ?? "";
    data['world_division_id'] = this.worldDivisionId ?? "";
    return data;
  }
}
