import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_app_bar.dart';
import '../../public_components/status_badges.dart';
import 'package:nfc_smart_attendance/screens/request_exemption/request_exemption_screen.dart';

class AttendanceHistoryDetailsScreen extends StatefulWidget {
  final String title;
  const AttendanceHistoryDetailsScreen({super.key, required this.title});

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
          widget.title,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(
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
                      "English For Professional",
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
                children: const [
                  Expanded(
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
                      "09P",
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
                children: const [
                  Expanded(
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
                      "Ts. Azma Binti Abdullah",
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
                children: const [
                  Expanded(
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
                      "26 March 2023 | 4.00pm",
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
                children: const [
                  Expanded(
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
                      "26 March 2023 | 6.00pm",
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
                  presentBadge(),
                  absentBadge(),
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
                  exemptionNeededBadge(),
                  exemptionSubmittedBadge(),
                  //noExemptionNeededBadge(),
                ],
              ),
              Expanded(child: Space(10)),
              DelayedDisplay(
                delay: Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ButtonPrimary("Submit Exemption", onPressed: () {
                    navigateTo(context, RequestExemptionScreen());
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
