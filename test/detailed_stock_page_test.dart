import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:stock_parser/app/modules/home/controllers/home_controller.dart';
import 'package:stock_parser/app/modules/home/views/detailed_stock_view.dart';
import 'package:stock_parser/app/modules/home/views/detailed_variable_page.dart';
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

  void fireOnTap(Finder finder, String text) {
    final Element element = finder.evaluate().single;
    final RenderParagraph paragraph = element.renderObject as RenderParagraph;
    // The children are the individual TextSpans which have GestureRecognizers
    paragraph.text.visitChildren((dynamic span) {
      if (kDebugMode) {
        print(text);
      }
      if (span.text != text) return true; // continue iterating.
      (span.recognizer as TapGestureRecognizer).onTap!();
      return false; // stop iterating, we found the one.
    });
  }

  setUpAll(() {
    controller = Get.put(HomeController());
    controller.getMockStocks();
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

  // check if on tapping a value variable the detailed variable page is rendered
  testWidgets("check if on tapping a value variable the detailed variable page is rendered", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: DetailedStockView(stock: controller.stocksList[0])));
    await tester.pumpAndSettle();
    final richText = find.byType(RichText).last;
    var values = controller.stocksList[0].criteria![0].variable!["\$2"]["values"];
    fireOnTap(richText, ("(${values[0].toString()})"));
    await tester.pumpAndSettle();
    expect(find.byType(DetailedVariablePage), findsOneWidget);
    // check if values list is rendered when the detailed variable is of the type "value"
    expect(find.byKey(AppKeys.variableValuesListKey), findsOneWidget);
  });

  final indicatorTextField = find.descendant(
    of: find.byKey(AppKeys.indicatorVariableTextFieldKey),
    matching: find.byType(EditableText),
  );

  // check if on tapping a indicator variable the detailed variable page is rendered
  testWidgets("check if on tapping a indicator variable the detailed variable page is rendered", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: DetailedStockView(stock: controller.stocksList[0])));
    await tester.pumpAndSettle();
    final richText = find.byType(RichText).last;
    fireOnTap(richText, ("(${controller.stocksList[0].criteria![0].variable!["\$1"]["default_value"].toString()})"));
    await tester.pumpAndSettle();
    expect(find.byType(DetailedVariablePage), findsOneWidget);
    // check if default value text-field is rendered when the detailed variable is of the type "indicator"
    expect(find.byKey(AppKeys.indicatorVariableTextFieldKey), findsOneWidget);
    // check if indicator text-field's keyboard type is number
    expect(tester.widget<EditableText>(indicatorTextField).keyboardType, TextInputType.number);
  });
}
