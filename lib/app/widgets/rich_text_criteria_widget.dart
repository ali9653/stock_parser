import 'package:flutter/cupertino.dart';
import 'package:stock_parser/app/utils/text_style_utils.dart';
import '../utils/padding_utils.dart';

class RichTextCriteriaWidget extends StatelessWidget {
  final List<TextSpan> textSpans;
  const RichTextCriteriaWidget({Key? key, required this.textSpans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: TextStyleUtils.whiteTitle,
          children: [
            ...textSpans,
          ],
        ),
      ),
    );
  }
}
