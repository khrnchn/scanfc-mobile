import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

const rootUrl = "http://10.0.2.2:8000/api/";

const kPrimaryColor = Color.fromRGBO(3, 4, 94, 1);
const kPrimary100Color = Color.fromRGBO(202, 240, 248, 1);
const kSecondaryColor = Color.fromRGBO(0, 119, 182, 1);
const kLightBlue = Color.fromRGBO(244, 247, 255, 1);
const kDisabledText = Color.fromARGB(255, 152, 152, 152);
const kWhite = Colors.white;
const kLightGrey = Color.fromRGBO(204, 204, 204, 1);
const kGrey = Colors.grey;
const kDarkGrey = Color.fromRGBO(64, 64, 64, 1);
const kBlack = Colors.black;
const kBgColor = Color.fromARGB(255, 252, 252, 252);
const kTransparent = Colors.transparent;
const kPrimaryLight = Color.fromARGB(255, 238, 250, 246);
const kDanger = Color.fromARGB(255, 209, 0, 10);
const kDisabledBg = Color.fromARGB(255, 224, 224, 224);
const kPrimaryLightColor = Color.fromRGBO(241, 244, 250, 1.0);
const kTextGray = Color.fromRGBO(0, 0, 0, 0.40);

// Success
const kBgSuccess = Color.fromRGBO(236, 253, 245, 1.0);
const kTextSuccess = kPrimaryColor;

// Danger
const kBgDanger = Color.fromRGBO(254, 242, 242, 1.0);
const kTextDanger = Color.fromRGBO(153, 27, 27, 1.0);

// Warning
const kBgWarning = Color.fromRGBO(255, 251, 235, 1.0);
const kTextWarning = Color.fromRGBO(188, 139, 20, 6);

// Info
const kBgInfo = Color.fromRGBO(236, 253, 245, 1.0);
const kTextInfo = kPrimaryColor;

const inputBoxShadowColor = Color(0x006d6d6d);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    kPrimaryColor,
    Color.fromRGBO(21, 52, 35, 1),
  ],
);

class DialogType {
  static const int info = 1;
  static const int danger = 2;
  static const int warning = 3;
  static const int success = 4;
}