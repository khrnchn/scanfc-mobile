import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';

Widget presentBadge() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgSuccess,
      border: Border.all(color: kTextSuccess),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      "Present",
      style: TextStyle(
        color: kTextSuccess,
        fontSize: 11,
      ),
    ),
  );
}

Widget absentBadge() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgDanger,
      border: Border.all(color: kTextDanger),
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Text(
      "Absent",
      style: TextStyle(
        color: kTextDanger,
        fontSize: 11,
      ),
    ),
  );
}

Widget exemptionNeededBadge() {
  return Container(
    margin: EdgeInsets.only(left: 5),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgWarning,
      border: Border.all(color: kTextWarning),
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Text(
      "Exemption Needed",
      style: TextStyle(
        color: kTextWarning,
        fontSize: 11,
      ),
    ),
  );
}

Widget exemptionSubmittedBadge() {
  return Container(
    margin: EdgeInsets.only(left: 5),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgInfo,
      border: Border.all(color: kTextInfo),
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Text(
      "Exemption Submitted",
      style: TextStyle(
        color: kTextInfo,
        fontSize: 11,
      ),
    ),
  );
}

Widget noExemptionNeededBadge() {
  return Container(
    margin: EdgeInsets.only(left: 5),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgSuccess,
      border: Border.all(color: kTextSuccess),
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Text(
      "No Exemption Needed",
      style: TextStyle(
        color: kTextSuccess,
        fontSize: 11,
      ),
    ),
  );
}

Widget faceToFaceBadge() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgSuccess,
      border: Border.all(color: kTextSuccess),
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Text(
      "Face To Face",
      style: TextStyle(
        color: kTextSuccess,
        fontSize: 11,
      ),
    ),
  );
}

Widget onlineClassBadge() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgInfo,
      border: Border.all(color: kTextInfo),
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Text(
      "Online",
      style: TextStyle(
        color: kTextInfo,
        fontSize: 11,
      ),
    ),
  );
}

Widget attendanceRecordedBadge() {
  return Container(
    margin: EdgeInsets.only(left: 5),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgInfo,
      border: Border.all(color: kTextInfo),
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Text(
      "Attendance Recorded",
      style: TextStyle(
        color: kTextInfo,
        fontSize: 11,
      ),
    ),
  );
}

Widget attendanceNotRecordedBadge() {
  return Container(
    margin: EdgeInsets.only(left: 5),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: kBgDanger,
      border: Border.all(color: kTextDanger),
      borderRadius: BorderRadius.circular(5),
    ),
    child: const Text(
      "Attendance Not Recorded",
      style: TextStyle(
        color: kTextDanger,
        fontSize: 11,
      ),
    ),
  );
}
