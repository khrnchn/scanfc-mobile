import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


InputDecoration textFieldInputDecoration(String labelText,
    {String? hintText, Icon? prefixIcon}) {
  return InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
    prefixIcon: prefixIcon,
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black.withOpacity(0.33),
      fontSize: 13,
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.black.withOpacity(0.33),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        width: 1.0,
        color: Colors.black.withOpacity(0.33),
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        width: 1.0,
        color: Colors.black.withOpacity(0.33),
      ),
    ),
  );
}

InputDecoration textFieldInputDecoration2({
  String? hintText,
}) {
  return InputDecoration(
    hintText: hintText,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    isDense: true,
    filled: true,
    border: InputBorder.none,
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    fillColor: kPrimaryLightColor,
    labelStyle: TextStyle(color: kTextGray, fontSize: 14),
    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.transparent),
    ),
  );
}

InputDecoration textFieldInputDecoration2Password({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    isDense: true,
    filled: true,
    border: InputBorder.none,
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    fillColor: kPrimaryLightColor,
    labelStyle: TextStyle(color: kTextGray, fontSize: 14),
    // contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  );
}

InputDecoration radioFieldInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    contentPadding: EdgeInsets.all(0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
          width: 0.0,
          // color: Colors.black.withOpacity(0.33),
          color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
          width: 0.0,
          // color: Colors.black.withOpacity(0.33),
          color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        width: 1.0,
        color: Colors.red.withOpacity(0.33),
      ),
    ),
  );
}

InputDecoration textFieldInputDecorationSmall({
  required String hintText,
  required Widget prefixIcon,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    hintText: hintText,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    isDense: true,
    filled: true,
    border: InputBorder.none,
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    fillColor: kPrimaryLightColor,
    labelStyle: TextStyle(color: kTextGray, fontSize: 14),
    contentPadding: EdgeInsets.fromLTRB(15, 8, 15, 8),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.transparent),
    ),
  );
}

InputDecoration textFieldInputPayFeeDecoration(String hintText) {
  return InputDecoration(
    prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SizedBox(
            width: 80,
            child: Row(children: [
              const Icon(
                Iconsax.info_circle,
                color: kDanger,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'RM',
                style: TextStyle(
                    color: kGrey.shade500,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    fontSize: 18),
              )
            ]))),
    suffix: const Text('BillPlz',
        style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            fontSize: 14)),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black.withOpacity(0.33),
      fontSize: 18,
    ),
    labelStyle: TextStyle(
      color: Colors.black.withOpacity(0.33),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    filled: true,
    fillColor: kWhite,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.33), width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        width: 1.0,
        color: Colors.grey.shade300,
      ),
    ),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
