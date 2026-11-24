import 'package:dio/dio.dart';
import 'package:flutter_analog_clock/core/networking/api_keys.dart';

class GetWeather {
  static Dio? _dio;
  static void initDio() {
    _dio = Dio(BaseOptions(baseUrl: 'https://api.weatherapi.com/v1/'));
  }

  Future<Response<dynamic>> getWeather() async {
    if (_dio == null) initDio();
    try {
      Response res = await _dio!.get(
        'current.json',
        queryParameters: {'key': ApiKeys.apiKey, 'q': 'Qena'},
      );
      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
