import 'dart:convert' as convert;

import 'package:bitcoins/data/model/data.dart';
import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/values/config.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient.internal();

  factory ApiClient() {
    return _instance;
  }

  ApiClient.internal();

  Future<Response> initListPrice() async {
    Response result;
    Data? data = await _getPrice();

    if (data != null) {
      Success success = Success(data: data);
      success.listData = await _getLastWeeksPrices();
      result = success;
    } else {
      result = NotSuccess(newError: "Failed request");
    }

    return result;
  }

  Future<Data?> _getPrice(
      {Map<String, dynamic>? query, String? currency}) async {
    Uri url;

    if (currency != null) {
      url = Uri.https(BASE_URL, '/v2/prices/BTC-$currency/spot', query);
    } else if (query != null) {
      url = Uri.https(BASE_URL, PRICE_URL, query);
    } else {
      url = Uri.https(BASE_URL, PRICE_URL);
    }
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return Data.fromJson(jsonResponse['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Data>> _getLastWeeksPrices() async {
    List<Data> _listData = [];

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');

    for (int i = 0; i < 14; i++) {
      var newDate = DateTime(now.year, now.month, now.day - 1);
      String formattedDate = formatter.format(newDate);

      Data? data = await _getPrice(query: {'date': formattedDate});

      if (data != null) {
        data.date = formattedDate;
        _listData.add(data);
      }
      now = newDate;
    }

    return _listData;
  }

  Future<Response> initDetailsPrices(String date) async {
    Response result;

    Success success =
        Success(data: Data(base: "BTC", amount: "0.0", currency: "USD"));
    success.listData = await _getDetailsPrices(date);

    if (success.listData.isEmpty) {
      result = NotSuccess(newError: "Failed request");
    } else {
      result = success;
    }
    return result;
  }

  Future<List<Data>> _getDetailsPrices(String date) async {
    List<Data> _listData = [];

    var _dataUSD = await _getPrice(query: {'date': date}, currency: "USD");
    if (_dataUSD != null) {
      _dataUSD.date = date;
      _listData.add(_dataUSD);
    }
    var _dataEUR = await _getPrice(query: {'date': date}, currency: "EUR");
    if (_dataEUR != null) {
      _dataEUR.date = date;
      _listData.add(_dataEUR);
    }
    var _dataCOP = await _getPrice(query: {'date': date}, currency: "COP");
    if (_dataCOP != null) {
      _dataCOP.date = date;
      _listData.add(_dataCOP);
    }

    return _listData;
  }
}
