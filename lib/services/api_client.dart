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

  /*FUNCION PARA OBTENER LOS DATOS NECESARIOS PARA prices_page.dart*/
  Future<Response> initListPrice() async {
    Response result;
    /*OBTENEMOS LOS PRECIOS DEL DIA DE HOY*/
    Data? data = await _getPrice();

    if (data != null) {
      /*ASIGNAMOS LOS DATOS CORRESPONDIENTES*/
      Success success = Success(data: data);

      /*OBTENEMOS LOS PRECIOS DE DOS SEMANAS ATRAS*/
      success.listData = await _getLastWeeksPrices();
      result = success;
    } else {
      /*ASIGNAMOS LOS DATOS CORRESPONDIENTES*/
      result = NotSuccess(newError: "Failed request");
    }

    return result;
  }

  Future<Data?> _getPrice(
      {Map<String, dynamic>? query, String? currency}) async {
    Uri url;

    /*VALIDO QUE EL PARAMETRO DE CURRENCY NO SE NULL PARA PODER REALIZAR LA PETICION PERSONALIZADA POR DIVISA*/
    if (currency != null) {
      url = Uri.https(BASE_URL, '/v2/prices/BTC-$currency/spot', query);
    } else if (query != null) {
      /*VALIDO QUE EL PARAMETRO DE QUERY NO SE NULL PARA PODER REALIZAR LA PETICION PERSONALIZADA POR FECHA*/
      url = Uri.https(BASE_URL, PRICE_URL, query);
    } else {
      /*PETICION NORMAL DEL VALOR DEL BTC A USD DEL DIA*/
      url = Uri.https(BASE_URL, PRICE_URL);
    }
    try {
      /*REAIZANDO PETICION GET*/
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //CON UNA RESPUESTA 200 PROCEDEMOS A CONVERTIR EL JSON A OBJECT
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

    /*OBTENEMOS LA FECHA DEL DIA*/
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');

    for (int i = 0; i < 14; i++) {
      /*RESTAMOS UN DIA */
      var newDate = DateTime(now.year, now.month, now.day - 1);
      String formattedDate = formatter.format(newDate);

      /*OBTENEMOS EL DATO DE ESE DIA*/
      Data? data = await _getPrice(query: {'date': formattedDate});

      if (data != null) {
        /*GUARDAMOS LA FECHA*/
        data.date = formattedDate;
        /*AGREGAMOS A NUESTRA LISTA*/
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
    /*OBTENEMOS LAS DIVISAS USD,EUR Y COP*/
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

    /*REALIZAMOS LA PETICION A USD*/
    var _dataUSD = await _getPrice(query: {'date': date}, currency: "USD");
    if (_dataUSD != null) {
      _dataUSD.date = date;
      _listData.add(_dataUSD);
    }

    /*REALIZAMOS LA PETICION A EUR*/
    var _dataEUR = await _getPrice(query: {'date': date}, currency: "EUR");
    if (_dataEUR != null) {
      _dataEUR.date = date;
      _listData.add(_dataEUR);
    }

    /*REALIZAMOS LA PETICION A COP*/
    var _dataCOP = await _getPrice(query: {'date': date}, currency: "COP");
    if (_dataCOP != null) {
      _dataCOP.date = date;
      _listData.add(_dataCOP);
    }

    return _listData;
  }
}
