import 'package:nfc_smart_attendance/bloc/change_password_bloc.dart';
import 'package:nfc_smart_attendance/helpers/validators.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/models/password/change_password_model.dart';
import 'package:nfc_smart_attendance/models/user/validate_password_response_model.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ChangePasswordFormBloc
    extends FormBloc<String, ValidatePasswordErrorsModel> {
  ChangePasswordBloc changePassword = new ChangePasswordBloc();

  final newPassword = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.passwordChar,
    ],
  );

  final confirmPassword = TextFieldBloc(
    validators: [InputValidator.required],
  );

  final currentPassword = TextFieldBloc(
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

  ChangePasswordFormBloc() {
    addFieldBlocs(fieldBlocs: [
      newPassword,
      currentPassword,
    ]);

    confirmPassword
      ..addValidators([_confirmPassword(newPassword)])
      ..subscribeToFieldBlocs([newPassword]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      ChangePasswordRequestModel requestModel =
          new ChangePasswordRequestModel();
      requestModel.newPassword = newPassword.value;

      requestModel.currentPassword = currentPassword.value;

      DefaultResponseModel responseModel =
          await changePassword.updatePassword(requestModel);

      if (responseModel.isSuccess) {
        emitSuccess(successResponse: responseModel.data);
      } else {
        emitFailure(failureResponse: responseModel.errors);
        print(responseModel.message);
      }
    } catch (e) {
      emitFailure(failureResponse: null);
    }
  }
}
