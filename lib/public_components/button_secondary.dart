import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter/material.dart';

class ButtonSecondary extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final IconData? icon;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double? marginHorizontal;
  final double? marginVertical;
  final Color? shadowColor;

  const ButtonSecondary(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.icon,
      this.paddingHorizontal,
      this.paddingVertical,
      this.marginHorizontal,
      this.shadowColor = kPrimaryColor,
      this.marginVertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: marginHorizontal == null ? 0.0 : marginHorizontal!,
        vertical: marginVertical == null ? 0 : marginVertical!,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(
            200,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          shadowColor: shadowColor,
          primary:
              kPrimaryColor, //text,icon & overlay, use surface for disabled state
          side: const BorderSide(color: kPrimaryColor),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal == null ? 0.0 : paddingHorizontal!,
            vertical: paddingVertical == null ? 0 : paddingVertical!,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon == null ? SizedBox() : Icon(icon),
              const SizedBox(
                width: 5,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
