import 'package:bitcoins/data/model/data.dart';
import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/values/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient.internal();

  factory ApiClient() {
    return _instance;
  }

  ApiClient.internal();

  Future<Response> initListPrice() async {
    Response result;
    Data? data = await _getPrice({});

    if (data != null) {
      Success success = Success(data: data);
      success.listData = await _getLastWeeksPrices();
      result = success;
    } else {
      result = NotSuccess(newError: "Failed request");
    }

    return result;
  }

  Future<Data?> _getPrice(Map<String, dynamic>? query) async {
    Uri url;

    if (query != null) {
      url = Uri.https(BASE_URL, PRICE_URL, query);
    } else {
      url = Uri.https(BASE_URL, PRICE_URL);
    }

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Data.fromJson(jsonResponse['data']);
    }
    return null;
  }

  Future<List<Data>> _getLastWeeksPrices() async {
    List<Data> _listData = [];

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');

    for (int i = 0; i < 14; i++) {
      var newDate = DateTime(now.year, now.month, now.day - 1);
      String formattedDate = formatter.format(newDate);

      Data? data = await _getPrice({'date': formattedDate});

      if (data != null) {
        data.date = formattedDate;
        _listData.add(data);
      }
      now = newDate;
    }

    return _listData;
  }
}
