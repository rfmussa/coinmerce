import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/coin_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<CoinModel>> getTopCoins() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/coins/markets'
          '?vs_currency=usd'
          '&order=market_cap_desc'
          '&per_page=10'
          '&page=1'
          '&sparkline=true'
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CoinModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load coins');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server with error: $e');
    }
  }
}
