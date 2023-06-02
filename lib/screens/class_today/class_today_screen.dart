import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/status_badges.dart';
import 'package:nfc_smart_attendance/screens/face_to_face_class/face_to_face_class_screen.dart';
import 'package:nfc_smart_attendance/screens/online_class/online_class_screen.dart';
import 'package:nfc_smart_attendance/theme.dart';

class ClassTodayScreen extends StatefulWidget {
  const ClassTodayScreen({super.key});

  @override
  State<ClassTodayScreen> createState() => _ClassTodayScreenState();
}

class _ClassTodayScreenState extends State<ClassTodayScreen> {
  int delayAnimationDuration = 100;
  String classMode = "Face to Face";

  bool isAttendanceSubmitted = false;

  void updateAttendance(bool submitted) {
    setState(() {
      isAttendanceSubmitted = submitted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 20, // Replace with your actual item count
      itemBuilder: (context, index) {
        return DelayedDisplay(
          delay: Duration(milliseconds: delayAnimationDuration),
          child: ScaleTap(
            onPressed: () async {
              print("navigate to scan nfc");
              var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return classMode != "Face to Face"
                        ? OnlineClassScreen(
                            classMode: classMode,
                            isAttendanceSubmitted: isAttendanceSubmitted,
                            updateAttendance: updateAttendance,
                          )
                        : FaceToFaceClassScreen(
                            classMode: classMode,
                            isAttendanceSubmitted: isAttendanceSubmitted,
                            updateAttendance: updateAttendance,
                          );
                  },
                ),
              );

              if (result != null && result is bool) {
                setState(() {
                  isAttendanceSubmitted = result;
                });
              }
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
                    profileShadow(
                      kPrimaryLight.withOpacity(0.2),
                    ),
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
                              faceToFaceBadge(),
                              if (isAttendanceSubmitted)
                                attendanceSubmittedBadge()
                              else
                                attendanceNotSubmittedBadge(),
                            ],
                          ),
                          //onlineClassBadge(),

                          Space(10),
                          Text(
                            "ISP641",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Space(3),
                          Text(
                            "E Commerce Application",
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
