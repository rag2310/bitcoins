import 'package:bitcoins/data/model/data.dart';
import 'package:bitcoins/data/utils/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiClient {
  static final ApiClient _instance = ApiClient.internal();

  factory ApiClient() {
    return _instance;
  }

  ApiClient.internal();

  Future<Response> initListPrice() async {
    Response result;
    var url = Uri.https('api.coinbase.com', '/v2/prices/BTC-USD/spot');

    var response = await http.get(url).catchError((onError) {
      result = NotSuccess(newError: "Error : $onError");
    });
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      Data data = Data.fromJson(jsonResponse['data']);

      result = Success(data: data);
      // result = NotSuccess(newError: "newError");
    } else {
      result = NotSuccess(
          newError: "Solicitud fallida con estado: ${response.statusCode}.");
    }

    return result;
  }
}
