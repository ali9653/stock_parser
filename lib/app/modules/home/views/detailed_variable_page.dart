import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_parser/app/models/stock_model.dart';
import 'package:stock_parser/app/utils/dimensions.dart';
import 'package:stock_parser/app/widgets/custom_appBar.dart';
import 'package:stock_parser/app/widgets/dotted_line_separation.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/padding_utils.dart';
import '../../../utils/text_style_utils.dart';

class DetailedVariablePage extends StatelessWidget {
  final VariableKey commonKey;
  final StockModel stock;

  const DetailedVariablePage({Key? key, required this.stock, required this.commonKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kScaffoldColor,
      appBar: customAppBar(),
      body: Visibility(
        visible: commonKey.type! == "value",
        child: ValueTypeVariable(commonKey: commonKey),
        replacement: IndicatorTypeVariable(commonKey: commonKey, stock: stock),
      ),
    );
  }
}

class ValueTypeVariable extends StatelessWidget {
  final VariableKey commonKey;

  const ValueTypeVariable({Key? key, required this.commonKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: commonKey.values!.length,
        itemBuilder: (context, index) {
          // sort the values in ascending order
          commonKey.values!.sort((a, b) => double.parse(a).abs().compareTo(double.parse(b).abs()));
          var value = commonKey.values![index];
          return ListTile(
            title: Text(
              value.toString(),
              style: TextStyleUtils.whiteTitle,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const DottedLineSeparator());
  }
}

class IndicatorTypeVariable extends StatelessWidget {
  final VariableKey commonKey;
  final StockModel stock;

  const IndicatorTypeVariable({Key? key, required this.commonKey, required this.stock}) : super(key: key);

  static Widget _spacer() {
    return const SizedBox(height: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PaddingUtils.kCommonPadding, vertical: PaddingUtils.kCommonPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stock.name!.split(" ")[0],
            style: TextStyleUtils.titleBold,
          ),
          _spacer(),
          const Text(
            "Set Parameters",
            style: TextStyleUtils.whiteTitle,
          ),
          _spacer(),
          Container(
            width: Dimens.width(100, context),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.white,
            height: 75,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Period",
                  style: TextStyleUtils.whiteTitle.copyWith(color: Colors.black),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: Dimens.width(40, context),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: commonKey.defaultValue!.toString(),
                    textAlign: TextAlign.left,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    style: TextStyleUtils.blackTitle,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
