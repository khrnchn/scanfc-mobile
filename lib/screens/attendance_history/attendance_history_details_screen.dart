import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/models/attendance_history/attendance_history_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_app_bar.dart';
import '../../public_components/status_badges.dart';
import 'package:nfc_smart_attendance/screens/request_exemption/request_exemption_screen.dart';

class AttendanceHistoryDetailsScreen extends StatefulWidget {
  final AttendanceHistoryModel attendanceHistoryModel;
  final Function() callbackRefresh;
  const AttendanceHistoryDetailsScreen(
      {super.key,
      required this.attendanceHistoryModel,
      required this.callbackRefresh});

  @override
  State<AttendanceHistoryDetailsScreen> createState() =>
      _AttendanceHistoryDetailsScreenState();
}

class _AttendanceHistoryDetailsScreenState
    extends State<AttendanceHistoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${widget.attendanceHistoryModel.classroom!.section!.subject!.code!} (${widget.attendanceHistoryModel.classroom!.classroomName})",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: kPrimaryColor,
          onPressed: () {
            Navigator.pop(context);
            widget.callbackRefresh();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "Subject:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      widget.attendanceHistoryModel.classroom!.section!
                          .subjectName!,
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "Section:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      widget.attendanceHistoryModel.classroom!.sectionName!,
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "Lecturer Name:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      widget.attendanceHistoryModel.classroom!.section!
                          .lecturerName!,
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "Start at:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      formatDate(
                          widget.attendanceHistoryModel.classroom!.startAt!),
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      "End at:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      formatDate(
                          widget.attendanceHistoryModel.classroom!.startAt!),
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Attendance Status: ",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  widget.attendanceHistoryModel.attendanceStatus ==
                          AttendanceStatus.present
                      ? presentBadge()
                      : (widget.attendanceHistoryModel.attendanceStatus ==
                              AttendanceStatus.absent
                          ? absentBadge()
                          : SizedBox()),
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Exemption Status: ",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // if absent, show exemption. Else no exemption needed
                  widget.attendanceHistoryModel.attendanceStatus ==
                          AttendanceStatus.absent
                      ? widget.attendanceHistoryModel.exemptionStatus ==
                              ExemptionStatus.needed
                          ? exemptionNeededBadge()
                          : widget.attendanceHistoryModel.exemptionStatus ==
                                  ExemptionStatus.submitted
                              ? exemptionSubmittedBadge()
                              : SizedBox()
                      : noExemptionNeededBadge(),
                ],
              ),
              Expanded(child: Space(0)),
              DelayedDisplay(
                delay: Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ButtonPrimary(
                    widget.attendanceHistoryModel.exemptionStatus ==
                            ExemptionStatus.needed
                        ? "Upload Exemption"
                        : "Exemption has been submitted",
                    isDisabled: widget.attendanceHistoryModel.exemptionStatus ==
                            ExemptionStatus.needed
                        ? false
                        : true,
                    onPressed: () {
                      navigateTo(
                        context,
                        RequestExemptionScreen(
                          attendanceHistoryModel: widget.attendanceHistoryModel,
                          callbackRefresh: widget.callbackRefresh,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    String day = dateTime.day.toString();
    String month = getMonthName(dateTime.month);
    String year = dateTime.year.toString();

    String hour = (dateTime.hour % 12).toString();
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String amPm = dateTime.hour < 12 ? 'am' : 'pm';

    return '$day $month $year | $hour.$minute$amPm';
  }

  String getMonthName(int month) {
    List<String> monthNames = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month];
  }
}
