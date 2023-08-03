import 'dart:convert';

import 'package:nfc_smart_attendance/models/class_today/list_class_today_response_model.dart';
import 'package:nfc_smart_attendance/services/resource.dart';

class ClassResource {
  static Resource getListClassToday() {
    return Resource(
        url: 'classrooms',
        parse: (response) {
          return ListClassTodayResponseModel(json.decode(response.body));
        });
  }
}
