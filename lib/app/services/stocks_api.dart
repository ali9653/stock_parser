import 'package:stock_parser/app/models/stock_model.dart';
import 'package:http/http.dart' as http;

class StocksAPI {
  static const String baseURL = "https://mobile-app-challenge.herokuapp.com/";

  static Future<List<StockModel>> fetchStocks() async {
    var url = Uri.parse("${baseURL}data");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<StockModel> stocks = stockModelFromJson(response.body);
      print(stocks);
      return stocks;
    } else {
      return <StockModel>[];
    }
  }
}
