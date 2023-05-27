import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/models/password/forgot_password_request_model.dart';
import 'package:nfc_smart_attendance/resource/forgot_password_resource.dart';
import 'package:nfc_smart_attendance/services/web_services.dart';

class ForgotPasswordBloc {
  Future<DefaultResponseModel> verifyEmail(String email) async {
    return await Webservice.post(ForgotPasswordResource.sendOTP(email));
  }

  Future<DefaultResponseModel> verifyOTP(String email, String otp) async {
    return await Webservice.post(ForgotPasswordResource.verifyOTP(email, otp));
  }

  Future<DefaultResponseModel> updatePassword(
      ForgotPasswordRequestModel requestModel) async {
    return await Webservice.post(
        ForgotPasswordResource.updatePassword(requestModel));
  }
}
