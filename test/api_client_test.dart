import 'package:bitcoins/data/utils/response.dart';
import 'package:bitcoins/services/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('Uso del API - prices_page.dart', () {
    test(
        'OBTENER EL PRECIO ACTUAL DEL BITCOIN A DOLARES, VALIDANDO EL CURRENCY',
        () async {
      final data = await ApiClient.internal().initListPrice();

      if (data is Success) {
        expect(data.data.currency, "USD");
      }
    });
    test('VALIDAR LA CANTIDAD DE DIAS OBTENIDOS POR LA LISTA', () async {
      final data = await ApiClient.internal().initListPrice();

      if (data is Success) {
        expect(data.listData.length, 14);
      }
    });
  });

  group('Uso del API - details_page.dart', () {
    test('VALIDAR LA CANTIDAD DE DIVISAS OBTENIDAS DE UN DIA ANTERIOR',
        () async {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');

      var newDate = DateTime(now.year, now.month, now.day - 1);
      String formattedDate = formatter.format(newDate);
      final data = await ApiClient.internal().initDetailsPrices(formattedDate);
      if (data is Success) {
        expect(data.listData.length, 3);
      }
    });

    test('VALIDAR LAS DIVISAS', () async {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');

      var newDate = DateTime(now.year, now.month, now.day - 1);
      String formattedDate = formatter.format(newDate);
      final data = await ApiClient.internal().initDetailsPrices(formattedDate);
      if (data is Success) {
        expect(data.listData[0].currency, 'USD');
        expect(data.listData[1].currency, 'EUR');
        expect(data.listData[2].currency, 'COP');


        expect(data.listData[0].base, 'BTC');
        expect(data.listData[1].base, 'BTC');
        expect(data.listData[2].base, 'BTC');
      }
    });
  });
}
