import 'package:flutter/material.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text("Attendance history")
      ],
    );
  }
}