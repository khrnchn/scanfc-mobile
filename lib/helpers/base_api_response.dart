import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/models/paginator_model.dart';
import 'package:nfc_smart_attendance/helpers/http_response.dart';
import 'package:nfc_smart_attendance/public_components/custom_dialog.dart';

abstract class BaseAPIResponse<Data, Errors> {
  bool isSuccess = false;
  String message = "Failed to fetch data from server, please try again later";
  int statusCode = HttpResponse.HTTP_GONE;
  Data? data;
  Errors? errors;
  PaginatorModel? paginator;

  BaseAPIResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }

  //Abstract json to data
  Data? jsonToData(Map<String, dynamic>? json);

  //Abstract json to errors
  Errors? jsonToError(Map<String, dynamic> json);

  //Abstract json to paginator
  PaginatorModel? jsonToPaginator(Map<String, dynamic> json);

  //Abstract data to json
  dynamic dataToJson(Data? data);

  //Abstract errors to json
  dynamic errorsToJson(Errors? errors);

  //Abstract errors to json
  PaginatorModel? paginatorToJson(PaginatorModel? paginatorModel);

  //Parsing data to object
  parsing(Map<String, dynamic> fullJson) {
    isSuccess = fullJson["is_success"] ?? false;
    message = fullJson["message"] ??
        (!isSuccess
            ? "Failed to fetch data from server, please try again later"
            : "");
    statusCode = fullJson["status_code"] ??
        (fullJson["message"] == "Unauthenticated."
            ? HttpResponse.HTTP_UNAUTHORIZED
            : HttpResponse.HTTP_INTERNAL_SERVER_ERROR);
    data = fullJson["data"] != null ? jsonToData(fullJson) : null;
    errors = fullJson["errors"] != null ? jsonToError(fullJson) : null;
    paginator =
        fullJson["paginator"] != null ? jsonToPaginator(fullJson) : null;
  }

  // Data to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataJson = new Map<String, dynamic>();
    dataJson['is_success'] = this.message;
    dataJson['message'] = this.message;
    dataJson['status_code'] = this.message;
    if (data != null) {
      dataJson['data'] = dataToJson(data);
    }
    if (errors != null) {
      dataJson['errors'] = errorsToJson(errors);
    }
    if (paginator != null) {
      dataJson['paginator'] = paginatorToJson(paginator);
    }
    return dataJson;
  }
}
