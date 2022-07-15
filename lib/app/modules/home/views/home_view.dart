import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_parser/app/utils/keys.dart';
import 'package:stock_parser/app/utils/loading_indicator.dart';
import 'package:stock_parser/app/widgets/custom_appBar.dart';
import 'package:stock_parser/app/widgets/dotted_line_separation.dart';
import 'package:stock_parser/app/widgets/stock_card.dart';
import '../../../utils/color_utils.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
        backgroundColor: AppColors.kScaffoldColor,
        appBar: customAppBar(),
        body: Obx(
          () => SizedBox(
            child: controller.isLoading.value
                ? circularIndicator(22, 2.5, Colors.white)
                : ListView.separated(
                    key: AppKeys.stocksListHomeKey,
                    itemCount: controller.stocksList.length,
                    itemBuilder: (context, index) => StockCard(stock: controller.stocksList[index]),
                    separatorBuilder: (BuildContext context, int index) => const DottedLineSeparator(),
                  ),
          ),
        ));
  }
}
