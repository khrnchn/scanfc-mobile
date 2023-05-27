import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String query;

  const EmptyList({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle = "",
    this.query = "_",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 56,
            color: kPrimaryColor,
          ),
          Space(15),
          Text(
            // If query == "", menas user not search yet, so just show nothing
            // query != "" ? text : "",
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kDarkGrey,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.normal, color: kGrey),
          )
        ],
      ),
    );
  }
}
