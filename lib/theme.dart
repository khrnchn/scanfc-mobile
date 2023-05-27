import 'package:nfc_smart_attendance/constant.dart';

import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    scrollbarTheme: ScrollbarThemeData(),
    fontFamily: "Poppins",
    // dialogTheme: dialogTheme(),
    textTheme: textTheme(),
    //inputDecorationTheme: inputDecoration(),
    //brightness: Brightness.dark,
    primaryColor: kPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: TextStyle(
          fontSize: 12,
        ),
        // side: BorderSide(color: kPrimaryColor),
      ),
    ),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kBlack),
    bodyText2: TextStyle(color: kBlack),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    iconTheme: IconThemeData(color: kBlack),
    backgroundColor: kTransparent,
    elevation: 0,
    centerTitle: true,
  );
}

BoxShadow sectionShadow() {
  return const BoxShadow(
    color: Color.fromRGBO(149, 149, 149, 0.15),
    blurRadius: 12.0,
  );
}

//TODO: change color shadow, offset, bluradius
BoxShadow profileShadow(Color color) {
  return BoxShadow(
    color: color,
    offset: Offset(2, 2),
    blurRadius: 12.0,
  );
}

BoxShadow itemShadow() {
  return const BoxShadow(
    color: Color.fromRGBO(136, 136, 136, 0.1),
    offset: Offset(0, 1),
    blurRadius: 12.0,
  );
}

TextStyle listTileTitleStyle() {
  return const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );
}
