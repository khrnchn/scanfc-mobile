import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:nfc_smart_attendance/constant.dart';

AppBar appBarMatrixId() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "Matric ID",
      style: TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kPrimaryColor,
              )),
    ),
  );
}

AppBar appBarClassToday() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "Class Today",
      style: TextStyle(
        color: kBlack,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kBlack,
              )),
    ),
  );
}

AppBar appBarChangePassword() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "Change Password",
      style: TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kPrimaryColor,
              )),
    ),
  );
}

AppBar appBarAttendanceHistory() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: const Text(
      "Attendance History",
      style: TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.transparent,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          ScaleTap(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                color: kPrimaryColor,
              )),
    ),
  );
}
