import 'package:flutter/cupertino.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:stock_parser/app/utils/padding_utils.dart';

class DottedLineSeparator extends StatelessWidget {
  const DottedLineSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PaddingUtils.kCommonPadding),
      child: const DottedLine(
        dashColor: Colors.white,
      ),
    );
  }
}
