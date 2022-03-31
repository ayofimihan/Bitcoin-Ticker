import 'dart:convert';
import 'package:dio/dio.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'NGN'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getHttp(currency) async {
    Dio _dio = Dio();
    final _baseUrl = 'https://apiv2.bitcoinaverage.com/indices';

    final String symbolSet = 'global';
    final String symbol = 'ETH$currency';
    String url = '$_baseUrl/$symbolSet/ticker/$symbol';

    print(url);

    try {
      Response userData = await _dio.get('$url',
          options: Options(headers: {
            'x-ba-key': 'MjM3Njc2ODBhY2IxNGFjMDgzNThjMDlhZDdiYWU3NGU'
          }));
      var data = userData.data;
      print(data.runtimeType);
      var last = (data['last']);
      print(last);
      return last;

      // print(userData.headers);
    } catch (e) {
      print("Exception: $e");
    }
  }
}
