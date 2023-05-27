import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constant.dart';


class ThemeSpinner {
  static spinnerInput() {
    return const SizedBox(
      height: 24,
      width: 24,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SpinKitDoubleBounce(
          color: kPrimaryColor,
          size: 24,
        ),
      ),
    );
  }

  static spinner() {
    return const SizedBox(
      height: 50,
      width: 50,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SpinKitChasingDots(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
