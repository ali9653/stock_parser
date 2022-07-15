import 'package:flutter/material.dart';
import 'package:stock_parser/app/utils/keys.dart';

Widget circularIndicator(double hw, double sw, Color color) {
  return Center(
      key: const Key("circular_loading_indicator"),
      child: SizedBox(
          height: hw,
          width: hw,
          child: Center(
              child: CircularProgressIndicator(
            key: AppKeys.loadingIndicatorKey,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: sw,
          ))));
}
