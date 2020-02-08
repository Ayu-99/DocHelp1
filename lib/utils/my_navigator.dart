import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/Register");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushNamed(context, "/intro");
  }

  static void goToMapping(BuildContext context) {
    Navigator.pushNamed(context, "/mapping");
  }
}