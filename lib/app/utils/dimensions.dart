import 'package:flutter/material.dart';

class Dimens {
  static double height(double i, BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return h * i / 100;
  }

  static double width(double i, BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return w * i / 100;
  }
}
