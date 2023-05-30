import 'package:flutter/material.dart';

class ClassTodayScreen extends StatefulWidget {
  const ClassTodayScreen({super.key});

  @override
  State<ClassTodayScreen> createState() => _ClassTodayScreenState();
}

class _ClassTodayScreenState extends State<ClassTodayScreen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text("Class Today")
      ],
    );
  }
}