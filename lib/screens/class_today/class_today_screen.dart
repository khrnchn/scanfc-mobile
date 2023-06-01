import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/status_badges.dart';
import 'package:nfc_smart_attendance/screens/face_to_face_class/face_to_face_class_screen.dart';
import 'package:nfc_smart_attendance/theme.dart';

class ClassTodayScreen extends StatefulWidget {
  const ClassTodayScreen({super.key});

  @override
  State<ClassTodayScreen> createState() => _ClassTodayScreenState();
}

class _ClassTodayScreenState extends State<ClassTodayScreen> {
  int delayAnimationDuration = 100;
  String classMode = "Face To Face";
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
              print("navigate to scan nfc");
              navigateTo(
                  context,
                  classMode == "Face To Face"
                      ? FaceToFaceClassScreen(
                          classMode: classMode,
                        )
                      : Placeholder());
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
                          faceToFaceBadge(),
                          //onlineClassBadge(),
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
