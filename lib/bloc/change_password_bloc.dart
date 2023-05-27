import 'package:nfc_smart_attendance/models/password/change_password_model.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/resource/change_password_resource.dart';
import 'package:nfc_smart_attendance/resource/forgot_password_resource.dart';
import 'package:nfc_smart_attendance/services/web_services.dart';

class ChangePasswordBloc {
  Future<DefaultResponseModel> verifyPassword(String password) async {
    return await Webservice.post(
        ChangePasswordResource.verifyPassword(password));
  }

  Future<DefaultResponseModel> updatePassword(
      ChangePasswordRequestModel requestModel) async {
    return await Webservice.post(
        ChangePasswordResource.updatePassword(requestModel));
  }
}
