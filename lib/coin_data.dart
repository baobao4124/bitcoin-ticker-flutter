import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const List<String> currenciesList = [
  'AUD',
  'VND',
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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apikey = '9667B845-962B-4B5C-A1E9-8664B1DAACE3';
const coinAPIURL  = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {

  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    final oCcy = new NumberFormat("#,##0", "en_US");

    for (String crypto in cryptoList) {
      var requestURL =
          Uri.parse('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apikey');
      http.Response response = await http.get(requestURL);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = oCcy.format(int.parse(price.toStringAsFixed(0)));
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return cryptoPrices;
  }
}
