import 'package:flutter/material.dart';
import 'package:stock_parser/app/utils/color_utils.dart';

class TextStyleUtils {
  static const TextStyle whiteTitle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle blackTitle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle titleBold = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subTitle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle underlined = TextStyle(
    color: AppColors.kUnderlinedTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
  );
}
