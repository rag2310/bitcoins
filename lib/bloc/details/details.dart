
import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/services/api_client.dart';

class Details {
  Stream<Response> get(String date) {
    return Stream.fromFuture(ApiClient.internal().initDetailsPrices(date));
  }
}