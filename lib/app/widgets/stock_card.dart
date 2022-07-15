import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_parser/app/models/stock_model.dart';
import 'package:stock_parser/app/modules/home/controllers/home_controller.dart';
import 'package:stock_parser/app/modules/home/views/detailed_stock_view.dart';
import 'package:stock_parser/app/utils/color_utils.dart';
import 'package:stock_parser/app/utils/text_style_utils.dart';

class StockCard extends GetView<HomeController> {
  final StockModel stock;

  const StockCard({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return ListTile(
      onTap: () => Get.to(() => DetailedStockView(stock: stock)),
      leading: Text(
        "•",
        style: TextStyle(color: Colors.grey.shade800, fontSize: 18),
      ),
      minLeadingWidth: 10,
      title: Text(
        stock.name!,
        style: TextStyleUtils.whiteTitle,
      ),
      subtitle: Text(
        stock.tag!,
        style: TextStyleUtils.subTitle.copyWith(color: controller.subtitleColor(stock)),
      ),
    );
  }
}
