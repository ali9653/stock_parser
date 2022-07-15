import 'package:flutter/material.dart';

Widget circularIndicator(double hw, double sw, Color color) {
  return Center(
      key: const Key("circular_loading_indicator"),
      child: SizedBox(
          height: hw,
          width: hw,
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: sw,
          ))));
}
