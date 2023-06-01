import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/screens/attendance_history/attendance_history_details_screen.dart';
import 'package:nfc_smart_attendance/theme.dart';
import '../../public_components/status_badges.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  int delayAnimationDuration = 100;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 20, // Replace with your actual item count
      itemBuilder: (context, index) {
        return DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: ScaleTap(
            onPressed: () {
              navigateTo(
                context,
                AttendanceHistoryDetailsScreen(title: "UHL2412"),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    profileShadow(kGrey.withOpacity(0.3)),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              //presentBadge(),
                              absentBadge(),
                              exemptionNeededBadge(),
                              exemptionSubmittedBadge(),
                            ],
                          ),
                          Space(10),
                          Text(
                            "UHL2412",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Space(3),
                          Text(
                            "English For Professional",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Space(10),
                          Text(
                            "26 March 2023 | 4.00pm",
                            style: TextStyle(
                              color: kPrimaryLight,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "09P",
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  
}
