import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:stock_parser/app/modules/home/controllers/home_controller.dart';
import 'package:stock_parser/app/modules/home/views/detailed_stock_view.dart';
import 'package:stock_parser/app/modules/home/views/home_view.dart';
import 'package:stock_parser/app/utils/color_utils.dart';
import 'package:stock_parser/app/utils/keys.dart';
import 'package:stock_parser/app/widgets/dotted_line_separation.dart';
import 'package:stock_parser/app/widgets/stock_card.dart';

main() {
  late HomeController controller;

  Widget createWidgetForTesting({required Widget child}) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: GetMaterialApp(
          home: child,
        ));
  }

  // check if String is "green" return Colors.green else return Colors.red
  Color checkIfColorIsGreen(String color) {
    if (color == "green") {
      return AppColors.kGreenColor;
    } else {
      return AppColors.kRedColor;
    }
  }

  setUpAll(() {
    controller = Get.put(HomeController());
    controller.getMockStocks();
  });

  // check if stocks data is rendered when api returns data
  testWidgets("check if stocks data is rendered after api response is returned", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const HomeView()));
    await tester.pumpAndSettle();
    // check if stocks list is rendered
    expect(find.byKey(AppKeys.stocksListHomeKey), findsOneWidget);
    // check if stock card is rendered
    expect(find.byType(StockCard), findsWidgets);
    // check if dotted line separator is rendered
    expect(find.byType(DottedLineSeparator), findsWidgets);
    // check if stock card is rendered with correct data
    for (var element in controller.stocksList) {
      expect(find.text(element.name!), findsWidgets);
      expect(find.text(element.tag!), findsWidgets);
      //check if color is green for bullish and red for bearish
      expect(((tester.firstWidget(find.text(element.tag!)) as Text).style)!.color, checkIfColorIsGreen(element.color!));
    }
  });

  // tap on stock card and check if stock details page is rendered
  testWidgets("check if stock details page is rendered after tapping on stock card", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const HomeView()));
    await tester.pumpAndSettle();
    // tap on stock card
    await tester.tap(find.text(controller.stocksList[0].name!));
    await tester.pumpAndSettle();
    // check if stock details page is rendered
    expect(find.byType(DetailedStockView), findsOneWidget);
    // check if stock details page is rendered with correct data
    expect(find.text(controller.stocksList[0].name!), findsOneWidget);
  });
}
