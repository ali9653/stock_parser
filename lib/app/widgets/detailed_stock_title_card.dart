import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/stock_model.dart';
import '../modules/home/controllers/home_controller.dart';
import '../utils/color_utils.dart';
import '../utils/text_style_utils.dart';

class DetailedStockTitle extends GetView<HomeController> {
  final StockModel stock;
  const DetailedStockTitle({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return ListTile(
      title: Text(
        stock.name!,
        style: TextStyleUtils.whiteTitle,
      ),
      subtitle: Text(
        stock.tag!,
        style: TextStyleUtils.subTitle.copyWith(color: controller.subtitleColor(stock)),
      ),
      tileColor: AppColors.kLightBlueColor,
    );
  }
}
