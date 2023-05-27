import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/public_components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

TextSpan highlightSpan(String content,
    {TextStyle style = const TextStyle(
      color: kPrimaryColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    )}) {
  return TextSpan(text: content, style: style);
}

TextSpan normalSpan(String content,
    {TextStyle style = const TextStyle(
      color: kPrimaryColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    )}) {
  return TextSpan(text: content, style: style);
}

Text getHighlight(String text, String highlight) {
  int start = 0;
  List<TextSpan> spans = [];
  int indexOfHighlight;
  final String _tempText = text;
  final String _tempHighlight = highlight;

  do {
    indexOfHighlight = _tempText.indexOf(_tempHighlight, start);
    if (indexOfHighlight < 0) {
      // no highlight
      spans.add(normalSpan(text.substring(start, text.length)));
      break;
    }
    if (indexOfHighlight == start) {
      // start with highlight.
      spans.add(highlightSpan(highlight));
      start += highlight.length;
    } else {
      // normal + highlight
      spans.add(normalSpan(text.substring(start, indexOfHighlight)));
      spans.add(highlightSpan(highlight));
      start = indexOfHighlight + highlight.length;
    }
  } while (true);

  return Text.rich(TextSpan(children: spans));
}

String secureEmail(String data) {
  // half left
  int middle = (data.length / 2).ceil();
  int midHalf = (middle / 2).ceil();
  int start = midHalf;
  //half right
  int end = middle + midHalf;
  int space = end - start;

  String secure = data.replaceRange(start, end, "*" * space);

  return secure;
}

// Popup if user want to cancel registration
Future<bool> showCancelRegistrationPopup(BuildContext context) async {
  // If cant pop then show this dialog
  // Unfocus from input field
  FocusScope.of(context).unfocus();
  // Show dialog
  return await CustomDialog.show(
        context,
        title: "Cancel Registration",
        description: "Are you sure to cancel the registration?",
        btnCancelText: "No",
        btnOkText: "Yes",
        btnCancelOnPress: () => Navigator.of(context).pop(),
        btnOkOnPress: () => Navigator.of(context).pop(true),
        icon: Iconsax.info_circle,
        dialogType: DialogType.warning,
      ) ??
      // If show dialog return null, return false
      false;
}

// Popup if user want to cancel forgot password
Future<bool> showCancelForgotPasswordPopup(BuildContext context) async {
  // If cant pop then show this dialog
  // Unfocus from input field
  FocusScope.of(context).unfocus();
  // Show dialog
  return await CustomDialog.show(
        context,
        title: "Cancel Reset Password",
        description: "Are you sure to cancel the reset password process?",
        btnCancelText: "No",
        btnOkText: "Yes",
        btnCancelOnPress: () => Navigator.of(context).pop(),
        btnOkOnPress: () => Navigator.of(context).pop(true),
        icon: Iconsax.info_circle,
        dialogType: DialogType.warning,
      ) ??
      // If show dialog return null, return false
      false;
}

// Popup if user want to exit the app
Future<bool> showExitAppPopup(BuildContext context) async {
  // If cant pop then show this dialog
  // Unfocus from input field
  FocusScope.of(context).unfocus();
  // Show dialog
  return await CustomDialog.show(
        context,
        title: "Quit App",
        description: "Are you sure you want to quit the app?",
        btnCancelText: "No",
        btnOkText: "Yes",
        btnCancelOnPress: () => Navigator.of(context).pop(),
        btnOkOnPress: () => Navigator.of(context).pop(true),
        icon: Iconsax.info_circle,
        dialogType: DialogType.warning,
      ) ??
      // If show dialog return null, return false
      false;
}

// To navigate to another page
void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class CapitalizeCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
