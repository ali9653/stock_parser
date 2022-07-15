import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_parser/app/modules/home/controllers/home_controller.dart';
import 'package:stock_parser/app/utils/padding_utils.dart';
import 'package:stock_parser/app/widgets/custom_appBar.dart';
import 'package:stock_parser/app/widgets/rich_text_criteria_widget.dart';
import '../../../models/stock_model.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/text_style_utils.dart';
import '../../../widgets/detailed_stock_title_card.dart';

class DetailedStockView extends GetView<HomeController> {
  final StockModel stock;

  const DetailedStockView({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.kScaffoldColor,
      appBar: customAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: PaddingUtils.kCommonPadding, vertical: PaddingUtils.kCommonPadding),
        child: Column(
          children: [
            DetailedStockTitle(stock: stock),
            Expanded(
              child: ListView.separated(
                itemCount: stock.criteria!.length,
                itemBuilder: (context, index) {
                  var criteria = stock.criteria![index];
                  return RichTextCriteriaWidget(textSpans: controller.criteriaSpans(stock, criteria));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: const Text(
                      "and",
                      style: TextStyleUtils.subTitle,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
