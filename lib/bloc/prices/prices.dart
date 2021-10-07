import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/services/api_client.dart';

class Prices {

  /*REALIZAMOS LAS PETICIONES NECESARIAS PARA INICIAR*/
  Stream<Response> get() {
    return Stream.fromFuture(ApiClient.internal().initListPrice());
  }

  /*REALIZA LA PETICION CADA 60 SEG PARA ACTUALIZAR LOS DATOS*/
  Stream<int> refresh() {
    return Stream.periodic(const Duration(seconds: 60), (x) => x).take(120);
  }
}
