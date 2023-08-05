import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc_smart_attendance/bloc/class_bloc.dart';
import 'package:nfc_smart_attendance/helpers/validators.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/models/request_exemption/request_exemption_request_model.dart';

class RequestExemptionFormBloc extends FormBloc<String, String> {
  ClassBloc classBloc = ClassBloc();
  XFile? newExemptionRequestFile;
  int attendanceHistoryId;

  final remarks = TextFieldBloc(
    validators: [],
  );

  RequestExemptionFormBloc(this.attendanceHistoryId) {
    addFieldBlocs(fieldBlocs: [
      remarks,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      RequestExemptionRequestModel requestModel =
          RequestExemptionRequestModel();
      requestModel.exemptionFile = newExemptionRequestFile;
      requestModel.remarks = remarks.value;

      DefaultResponseModel responseModel = await classBloc.requestExemption(
        requestModel,
        attendanceHistoryId,
      );

      print(attendanceHistoryId);

      if (responseModel.isSuccess) {
        emitSuccess(successResponse: responseModel.data);
      } else {
        emitFailure(failureResponse: responseModel.errors);
        print(responseModel.message);
      }
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
