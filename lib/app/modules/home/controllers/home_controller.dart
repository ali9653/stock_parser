import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_parser/app/modules/home/views/detailed_variable_page.dart';
import 'package:stock_parser/app/services/mock_data.dart';
import 'package:stock_parser/app/utils/color_utils.dart';
import 'package:stock_parser/app/utils/text_style_utils.dart';

import '../../../models/stock_model.dart';
import '../../../services/stocks_api.dart';

class HomeController extends GetxController {
  var stocksList = <StockModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    // comment this  api call while testing
    getStocks();
    super.onInit();
  }

  Future<void> getStocks() async {
    isLoading.value = true;
    var stocks = await StocksAPI.fetchStocks();
    stocksList.assignAll(stocks);
    isLoading.value = false;
  }

  void getMockStocks() {
    stocksList.assignAll(MockData().getMockStocks());
  }

  Color subtitleColor(StockModel stock) {
    if (stock.color! == "green") {
      return AppColors.kGreenColor;
    } else {
      return AppColors.kRedColor;
    }
  }

  List<TextSpan> criteriaSpans(StockModel stock, Criteria criteria) {
    List<TextSpan> criteriaSpans = [];
    String criteriaProcessedText = "";
    // check if key in criteria is empty (null) then add it directly to the spans list
    if (criteria.variable! == "") {
      criteriaSpans.add(TextSpan(
        text: criteria.text!,
        style: TextStyleUtils.whiteTitle,
      ));
    } else {
      for (String character in criteria.text!.characters) {
        criteriaProcessedText += character;

        // check if character contains "$", if so, then remove it and remove the next character
        if (character == "\$") {
          criteriaProcessedText = criteriaProcessedText.substring(0, criteriaProcessedText.length - 1);
          criteriaSpans.add(TextSpan(
            text: criteriaProcessedText,
            style: TextStyleUtils.whiteTitle,
          ));
          criteriaProcessedText = "\$";
        }
        // Check if criteriaProcessedText contains "$", if so, then loop through the criteria.key

        else if (criteriaProcessedText.contains("\$")) {
          for (String key in criteria.variable!.keys) {
            if (key == criteriaProcessedText) {
              criteriaProcessedText = "";
              String updatedVariable = "";
              // Check if criteria.key![key]["type"] is "indicator" or "value"
              var type = criteria.variable![key]["type"];
              if (type == "indicator") {
                updatedVariable = criteria.variable![key]["default_value"].toString();
              } else {
                updatedVariable = criteria.variable![key]["values"][0].toString();
              }
              criteriaSpans.add(TextSpan(
                text: "($updatedVariable)",
                style: TextStyleUtils.underlined,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.to(
                        () => DetailedVariablePage(
                          stock: stock,
                          commonKey: VariableKey.fromJson(criteria.variable![key]),
                        ),
                      ),
              ));
            }
          }
        }
        // check  for the last character eg. "%" or "x"
        else if (character == criteria.text!.characters.last) {
          criteriaSpans.add(
            TextSpan(
              text: criteriaProcessedText,
              style: TextStyleUtils.whiteTitle,
            ),
          );
        }
      }
    }
    return criteriaSpans;
  }
}
