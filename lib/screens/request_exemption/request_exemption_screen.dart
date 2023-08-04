import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:nfc_smart_attendance/form_bloc/request_exemption_form_bloc.dart';
import 'package:nfc_smart_attendance/models/attendance_history/attendance_history_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/input_decoration.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/screens/request_exemption/components/file_uploader.dart';

class RequestExemptionScreen extends StatefulWidget {
  final AttendanceHistoryModel attendanceHistoryModel;
  const RequestExemptionScreen({super.key, required this.attendanceHistoryModel});

  @override
  State<RequestExemptionScreen> createState() => _RequestExemptionScreenState();
}

class _RequestExemptionScreenState extends State<RequestExemptionScreen> {
  XFile? _selectedFile;
  int delayAnimationDuration = 200;
  RequestExemptionFormBloc requestExemptionFormBloc =
      RequestExemptionFormBloc();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Request Exemption",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: kPrimaryColor,
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: UploadFile(
                      formBloc: requestExemptionFormBloc,
                      onFileSelected: (XFile selectedFile) {
                        setState(() {
                          _selectedFile = selectedFile;
                        });
                      },
                    ),
                  ),
                  Space(10),
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: const Text(
                      "Please upload your exemption proof. The format can be in 'pdf', 'png', 'jpeg', 'jpg'. ",
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Space(10),
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: TextFieldBlocBuilder(
                      maxLines: 8,
                      textFieldBloc: requestExemptionFormBloc.remarks,
                      keyboardType: TextInputType.multiline,
                      cursorColor: kPrimaryColor,
                      decoration: textFieldInputDecoration(
                        "Remarks (Optional)",
                        hintText: "ex: My cat is sick that day",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: ButtonPrimary("Submit Exemption", onPressed: () {
              print("submit exemption");
            }),
          ),
        ),
      ),
    );
  }
}
