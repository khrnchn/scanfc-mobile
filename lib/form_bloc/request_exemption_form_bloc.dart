import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RequestExemptionFormBloc extends FormBloc<String, String> {
  XFile? newExemptionRequestFile;

  final remarks = TextFieldBloc();

  RequestExemptionFormBloc() {
    addFieldBlocs(fieldBlocs: [
      remarks,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      // Account details

      //TODO: jadikan XFile profilePhoto ke String picURL
      //requestModel.userModel!.profilePhoto = newProfilePhoto;

      // Call API
      // DefaultResponseModel responseModel =
      //     await userBloc.register(requestModel);

      // // Handle response
      // if (responseModel.isSuccess) {
      //   emitSuccess(successResponse: email.value.trim());
      // } else {
      //   emitFailure(failureResponse: responseModel.message);
      // }
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
