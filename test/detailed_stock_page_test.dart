import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:stock_parser/app/modules/home/controllers/home_controller.dart';
import 'package:stock_parser/app/modules/home/views/detailed_stock_view.dart';
import 'package:stock_parser/app/utils/keys.dart';
import 'package:stock_parser/app/widgets/detailed_stock_title_card.dart';

main() {
  late HomeController controller;

  Widget createWidgetForTesting({required Widget child}) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: GetMaterialApp(
          home: child,
        ));
  }

  setUpAll(() async {
    controller = Get.put(HomeController());
    HttpOverrides.global = null;
    await controller.getStocks();
  });

  // check if the detailed stock matches the first stock in the list
  testWidgets("check if the detailed stock matches the first stock in the list", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: DetailedStockView(stock: controller.stocksList[0])));
    await tester.pumpAndSettle();
    expect(find.text(controller.stocksList[0].name!), findsOneWidget);
  });

  // check if detailed stock title card is rendered
  testWidgets("check if detailed stock title card is rendered", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: DetailedStockView(stock: controller.stocksList[0])));
    await tester.pumpAndSettle();
    // check if detailed stock title card is rendered
    expect(find.byType(DetailedStockTitle), findsOneWidget);
  });

  // check if detailed stocks list is rendered
  testWidgets("check if detailed stocks list is rendered", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: DetailedStockView(stock: controller.stocksList[0])));
    await tester.pumpAndSettle();
    // check if detailed stocks list is rendered
    expect(find.byKey(AppKeys.detailedStocksListKey), findsOneWidget);
  });

  // check if detailed stock list is separated by "and" when there are more than 1 stocks
  testWidgets("check if detailed stock list is separated by 'and' when there are more than 1 stocks",
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: DetailedStockView(stock: controller.stocksList[1])));
    await tester.pumpAndSettle();
    // check if detailed stock list is separated by "and" when there are more than 1 stocks
    expect(find.text("and"), findsWidgets);
  });
}
