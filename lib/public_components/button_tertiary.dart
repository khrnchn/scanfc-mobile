import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter/material.dart';

class ButtonTertiary extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final IconData? icon;
  final Color? primaryColor;
  final Color? shadowColor;
  final Color? textColor;
  final Size? size;
  const ButtonTertiary(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.icon,
      this.primaryColor = Colors.red,
      this.shadowColor = Colors.red,
      this.textColor,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          // side: BorderSide(color: Colors.red)
        ),
        fixedSize: size,
        shadowColor: shadowColor,
        onPrimary: textColor,
        primary:
            primaryColor, //text,icon & overlay, use surface for disabled state
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon == null ? const SizedBox() : Icon(icon),
          const SizedBox(
            width: 5,
          ),
          Text(text),
        ],
      ),
    );
  }
}
