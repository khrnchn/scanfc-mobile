import 'package:nfc_smart_attendance/bloc/forgot_password_bloc.dart';
import 'package:nfc_smart_attendance/helpers/validators.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/models/password/forgot_password_request_model.dart';
import 'package:nfc_smart_attendance/models/user/validate_password_response_model.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ForgotPasswordFormBloc
    extends FormBloc<String, ValidatePasswordErrorsModel> {
  ForgotPasswordBloc forgotPassword = new ForgotPasswordBloc();

  final String email;
  final String otp;

  final newPassword = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.passwordChar,
    ],
  );

  final confirmPassword = TextFieldBloc(
    validators: [InputValidator.required],
  );

  Validator<String> _confirmPassword(
    TextFieldBloc newPasswordTextFieldBloc,
  ) {
    return (String confirmPassword) {
      if (confirmPassword == newPasswordTextFieldBloc.value) {
        return null;
      }
      return "Your password do not match";
    };
  }

  ForgotPasswordFormBloc(this.email, this.otp) {
    addFieldBlocs(fieldBlocs: [
      newPassword,
      confirmPassword,
    ]);

    confirmPassword
      ..addValidators([_confirmPassword(newPassword)])
      ..subscribeToFieldBlocs([newPassword]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      ForgotPasswordRequestModel requestModel =
          new ForgotPasswordRequestModel();
      requestModel.password = newPassword.value;
      requestModel.passwordConfirmation = confirmPassword.value;
      requestModel.email = email;
      requestModel.otp = otp;

      DefaultResponseModel responseModel =
          await forgotPassword.updatePassword(requestModel);

      if (responseModel.isSuccess) {
        emitSuccess(successResponse: responseModel.data);
      } else {
        emitFailure(failureResponse: responseModel.errors);
      }
    } catch (e) {
      emitFailure(failureResponse: null);
    }
  }
}
