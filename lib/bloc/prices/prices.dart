import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/services/api_client.dart';

class Prices {
  Stream<Response> get() {
    return Stream.fromFuture(ApiClient.internal().initListPrice());
  }
}
