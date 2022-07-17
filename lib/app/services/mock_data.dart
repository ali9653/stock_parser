import 'package:stock_parser/app/models/stock_model.dart';

class MockData {
  var stocks = [
    {
      "id": 4,
      "name": "CCI Reversal",
      "tag": "Bearish",
      "color": "red",
      "criteria": [
        {
          "type": "variable",
          "text": "CCI \$1 crosses below \$2",
          "variable": {
            "\$1": {
              "type": "indicator",
              "study_type": "cci",
              "parameter_name": "period",
              "min_value": 1,
              "max_value": 99,
              "default_value": 20
            },
            "\$2": {
              "type": "value",
              "values": [100, 200]
            }
          }
        }
      ]
    },
    {
      "id": 5,
      "name": "RSI Overbought",
      "tag": "Bearish",
      "color": "red",
      "criteria": [
        {
          "type": "variable",
          "text": "Max of last 5 days close \u003e Max of last 120 days close by \$1 %",
          "variable": {
            "\$1": {
              "type": "value",
              "values": [2, 1, 3, 5]
            }
          }
        },
        {
          "type": "variable",
          "text": "Today's Volume \u003e prev \$2 Vol SMA by \$3 x",
          "variable": {
            "\$2": {
              "type": "value",
              "values": [10, 5, 20, 30]
            },
            "\$3": {
              "type": "value",
              "values": [1.5, 0.5, 1, 2, 3]
            }
          }
        },
        {
          "type": "variable",
          "text": "RSI \$4 \u003e 20",
          "variable": {
            "\$4": {
              "type": "indicator",
              "study_type": "rsi",
              "parameter_name": "period",
              "min_value": 1,
              "max_value": 99,
              "default_value": 14
            }
          }
        }
      ]
    }
  ];

  List<StockModel> getMockStocks() {
    return stocks.map((stock) => StockModel.fromJson(stock)).toList();
  }
}
