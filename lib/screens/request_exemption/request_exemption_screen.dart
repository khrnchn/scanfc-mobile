import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:nfc_smart_attendance/form_bloc/request_exemption_form_bloc.dart';
import 'package:nfc_smart_attendance/models/attendance_history/attendance_history_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/custom_dialog.dart';
import 'package:nfc_smart_attendance/public_components/input_decoration.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';
import 'package:nfc_smart_attendance/screens/request_exemption/components/file_uploader.dart';

class RequestExemptionScreen extends StatefulWidget {
  final AttendanceHistoryModel attendanceHistoryModel;
  final Function() callbackRefresh;
  const RequestExemptionScreen(
      {super.key,
      required this.attendanceHistoryModel,
      required this.callbackRefresh});

  @override
  State<RequestExemptionScreen> createState() => _RequestExemptionScreenState();
}

class _RequestExemptionScreenState extends State<RequestExemptionScreen> {
  XFile? _selectedFile;
  bool _isLoading = false;
  int delayAnimationDuration = 200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        body: BlocProvider(
          create: (context) =>
              RequestExemptionFormBloc(widget.attendanceHistoryModel.id!),
          child: Builder(builder: (context) {
            final RequestExemptionFormBloc formBloc =
                BlocProvider.of<RequestExemptionFormBloc>(context);

            return FormBlocListener<RequestExemptionFormBloc, String, String>(
              onSubmitting: (context, state) {
                // Remove focus from input field
                FocusScope.of(context).unfocus();
                // Set loading true
                setState(() {
                  _isLoading = true;
                });
              },
              onSuccess: (context, state) {
                // Set loading false
                setState(() {
                  _isLoading = false;
                });

                CustomDialog.show(
                  context,
                  isDissmissable: false,
                  icon: Iconsax.tick_circle,
                  title: "Successfully submit exemption",
                  btnOkText: "OK",
                  btnOkOnPress: () async {
                    // matikan dialog
                    Navigator.pop(context);

                    // back to details attendance screen
                    Navigator.pop(context);

                    //back to list history screen
                    Navigator.pop(context);

                    widget.callbackRefresh();
                  },
                );
              },
              onSubmissionFailed: (context, state) {
                // Set loading false
                setState(() {
                  _isLoading = false;
                });
              },
              onFailure: (context, state) {
                // Set loading false
                setState(() {
                  _isLoading = false;
                });

                ThemeSnackBar.showSnackBar(
                    context, "Fail to submit exemption proof");
              },
              child: GestureDetector(
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
                            formBloc: formBloc,
                            attendanceStatus:
                                widget.attendanceHistoryModel.attendanceStatus,
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
                            "Please upload your exemption proof. The format can be in 'png', 'jpeg', 'jpg'. ",
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
                            isEnabled: widget.attendanceHistoryModel
                                        .attendanceStatus ==
                                    AttendanceStatus.present
                                ? false
                                : true,
                            maxLines: 8,
                            textFieldBloc: formBloc.remarks,
                            keyboardType: TextInputType.multiline,
                            cursorColor: kPrimaryColor,
                            decoration: textFieldInputDecoration(
                              "Remarks (Optional)",
                              hintText: "ex: My cat is sick that day",
                            ),
                          ),
                        ),
                        Space(30),
                        DelayedDisplay(
                          delay: Duration(milliseconds: delayAnimationDuration),
                          child: ButtonPrimary(
                            "Submit Exemption",
                            isDisabled: widget.attendanceHistoryModel
                                        .attendanceStatus ==
                                    AttendanceStatus.present
                                ? true
                                : false,
                            onPressed: () {
                              if (formBloc.newExemptionRequestFile == null) {
                                ThemeSnackBar.showSnackBar(
                                    context, "Exemption Image is required");
                              }
                              return formBloc.submit();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
