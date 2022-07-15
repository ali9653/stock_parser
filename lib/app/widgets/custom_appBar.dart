import 'package:flutter/material.dart';
import '../utils/color_utils.dart';

PreferredSizeWidget customAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      backgroundColor: AppColors.kScaffoldColor,
      automaticallyImplyLeading: true,
    ),
  );
}
